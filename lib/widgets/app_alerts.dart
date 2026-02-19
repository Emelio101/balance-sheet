import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showInfoSnackBar(
  BuildContext context, {
  String message = '',
  int seconds = 4,
}) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      defaultSnackBar(message, seconds, MessageType.info),
    );
  }
}

void showSuccessSnackBar(
  BuildContext context, {
  String message = '',
  int seconds = 2,
}) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      defaultSnackBar(message, seconds, MessageType.success),
    );
  }
}

Future<void> showErrorSnackBar(
  BuildContext context, {
  String message = '',
  int seconds = 4,
  VoidCallback? onClosed,
}) async {
  if (context.mounted) {
    final snackBar = defaultSnackBar(message, seconds, MessageType.error);
    await ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
      onClosed?.call();
    });
  }
}

enum MessageType { info, success, error }

void showAppSnackBar(
  ScaffoldMessengerState messenger, {
  String message = '',
  int seconds = 4,
  MessageType type = MessageType.info,
}) {
  messenger.showSnackBar(defaultSnackBar(message, seconds, type));
}

SnackBar defaultSnackBar(String message, int seconds, MessageType type) {
  Color color;
  Color iconBgColor;
  Color darkColor;
  IconData iconData;
  String title;
  if (type == MessageType.success) {
    color = Colors.black;
    iconBgColor = const Color(0xFF71e0b6);
    darkColor = Colors.white;
    iconData = Icons.check_circle;
    title = 'Success';
  } else if (type == MessageType.error) {
    color = Colors.black;
    iconBgColor = const Color(0xFFff5436);
    darkColor = Colors.white;
    iconData = Icons.error;
    title = 'Notice';
  } else {
    color = Colors.black;
    iconBgColor = const Color(0xFF71e0b6);
    darkColor = Colors.white;
    iconData = Icons.info;
    title = 'Info';
  }

  return SnackBar(
    content: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: iconBgColor,
          ),
          child: Icon(iconData, color: darkColor),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: '$title. ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: message,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    duration: Duration(seconds: seconds),
    backgroundColor: darkColor,
    padding: const EdgeInsets.all(24),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}

enum DialogType { info, yesNo, select }

class DialogOption {
  DialogOption({required this.text, this.value, this.selected = false});

  final dynamic value;
  final String text;
  final bool selected;
}

Future<dynamic> showAppDialog(
  BuildContext context, {
  required String title,
  required String message,
  String yesText = 'Yes',
  String noText = 'No',
  DialogType dialogType = DialogType.yesNo,
  VoidCallback? onConfirm,
  List<DialogOption> options = const [],
  void Function(dynamic)? onSelect,
  bool barrierDismissible = true,
}) async {
  return showDialog<dynamic>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => _AppAlertDialog(
      title: title,
      message: message,
      yesText: yesText,
      noText: noText,
      dialogType: dialogType,
      onConfirm: onConfirm,
      onSelect: onSelect,
      options: options,
    ),
  );
}

class _AppAlertDialog extends StatelessWidget {
  const _AppAlertDialog({
    required this.title,
    required this.message,
    required this.yesText,
    required this.noText,
    required this.dialogType,
    this.onConfirm,
    this.onSelect,
    this.options = const [],
  });

  final String title;
  final String message;
  final String yesText;
  final String noText;
  final DialogType dialogType;
  final VoidCallback? onConfirm;
  final void Function(dynamic)? onSelect;
  final List<DialogOption> options;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            if (dialogType != DialogType.select)
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(6),
                      bottom: Radius.circular(
                        dialogType == DialogType.yesNo ? 2 : 6,
                      ),
                    ),
                  ),
                ),
                child: Text(yesText),
                onPressed: () {
                  Navigator.pop(context, true);
                  onConfirm?.call();
                },
              ),
            const SizedBox(height: 4),
            if (dialogType == DialogType.yesNo)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(2),
                      bottom: Radius.circular(6),
                    ),
                  ),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Text(noText),
              )
            else if (dialogType == DialogType.select)
              ...List.generate(options.length, (i) {
                final option = options[i];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (option.selected)
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
                          onSelect?.call(option.value);
                        },
                        icon: const Icon(Icons.check),
                        label: Text(option.text),
                      )
                    else
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, true);
                          onSelect?.call(option.value);
                        },
                        child: Text(
                          option.text,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                    const SizedBox(height: 8),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> showCustomAppDialog(
  BuildContext context, {
  required String title,
  required Widget child,
  required String message,
  String continueText = 'Continue',
  VoidCallback? onContinue,
  bool barrierDismissible = true,
}) async {
  return showDialog<dynamic>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => _CustomAppDialog(
      title: title,
      message: message,
      continueText: continueText,
      onContinue: onContinue,
      child: child,
    ),
  );
}

class _CustomAppDialog extends StatelessWidget {
  const _CustomAppDialog({
    required this.title,
    required this.child,
    required this.continueText,
    required this.message,
    this.onContinue,
  });

  final String title;
  final String message;
  final Widget child;
  final String continueText;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 14),
            ),
            const SizedBox(height: 16),
            child,
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(
                continueText,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context, true);
                onContinue?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
