import 'package:balance_sheet/models/transaction_model.dart';
import 'package:balance_sheet/transactions/cubit/transactions_cubit.dart';
import 'package:balance_sheet/widgets/app_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailsDialog extends StatelessWidget {
  const TransactionDetailsDialog({
    required this.transaction,
    required this.currencySymbol,
    super.key,
  });

  final TransactionModel transaction;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withValues(alpha: 0.2),
                    color.withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isIncome
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                color: color,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),

            // Transaction Title
            Text(
              transaction.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Amount
            Text(
              '${isIncome ? '+' : '-'}$currencySymbol${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 24),

            // Details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    context,
                    icon: Icons.category_rounded,
                    label: 'Category',
                    value: transaction.category,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    context,
                    icon: Icons.calendar_today_rounded,
                    label: 'Date',
                    value: _formatDate(transaction.date),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    context,
                    icon: Icons.label_rounded,
                    label: 'Type',
                    value: isIncome ? 'Income' : 'Expense',
                  ),
                  if (transaction.description.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      context,
                      icon: Icons.notes_rounded,
                      label: 'Description',
                      value: transaction.description,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    label: const Text('Close'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _deleteTransaction(context),
                    icon: const Icon(Icons.delete_rounded),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Future<void> _deleteTransaction(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Delete Transaction'),
        content: const Text(
          'Are you sure you want to delete this transaction? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TransactionsCubit>().removeTransaction(
                transaction.id,
              );
              Navigator.pop(dialogContext);
              Navigator.pop(context);

              showSuccessSnackBar(
                context,
                message: '${transaction.title} deleted successfully',
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
