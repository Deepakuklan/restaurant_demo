import 'package:flutter/material.dart';

class CommonPopup extends StatelessWidget {
  final String title;
  final String message;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositivePressed;
  final VoidCallback? onNegativePressed;

  const CommonPopup({
    super.key,
    required this.title,
    required this.message,
    this.positiveButtonText,
    this.negativeButtonText,
    this.onPositivePressed,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (negativeButtonText != null)
          TextButton(
            onPressed: onNegativePressed ?? () => Navigator.of(context).pop(),
            child: Text(negativeButtonText!),
          ),
        if (positiveButtonText != null)
          TextButton(onPressed: onPositivePressed, child: Text(positiveButtonText!)),
      ],
    );
  }
}
