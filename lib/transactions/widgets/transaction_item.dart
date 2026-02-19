import 'package:balance_sheet/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required this.transaction,
    super.key,
    this.onDismissed,
    this.onTap,
    this.currencySymbol = r'$',
  });

  final TransactionModel transaction;
  final void Function(DismissDirection)? onDismissed;
  final VoidCallback? onTap;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Dismissible(
      key: Key(transaction.id),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_rounded,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(height: 4),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withValues(alpha: 0.2),
                        color.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getCategoryIcon(transaction.category),
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Title and Category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              transaction.category,
                              style: TextStyle(
                                color: color,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.access_time_rounded,
                            size: 12,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getTimeAgo(transaction.date),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isIncome ? '+' : '-'}$currencySymbol${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Icon(
                      isIncome
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      color: color,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant_rounded;
      case 'housing':
        return Icons.home_rounded;
      case 'transport':
        return Icons.directions_car_rounded;
      case 'entertainment':
        return Icons.movie_rounded;
      case 'healthcare':
        return Icons.local_hospital_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'utilities':
        return Icons.bolt_rounded;
      case 'salary':
        return Icons.payments_rounded;
      case 'business':
        return Icons.business_rounded;
      case 'investment':
        return Icons.trending_up_rounded;
      case 'freelance':
        return Icons.laptop_rounded;
      case 'gift':
        return Icons.card_giftcard_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }
}
