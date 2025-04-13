import 'package:flutter/material.dart';

import '../utils/app_Colors.dart';
import '../utils/app_text_widgets.dart';

Future<void> showCustomConfirmationDialog({
  required BuildContext context,
  String title = 'Are you sure?',
  required String message,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  String confirmText = 'Yes, change it!',
  String cancelText = 'Cancel',
}) {
  return showDialog(
    context: context,
    builder: (_) => _AnimatedConfirmationDialog(
      title: title,
      message: message,
      onConfirm: onConfirm,
      onCancel: onCancel,
      confirmText: confirmText,
      cancelText: cancelText,
    ),
  );
}

class _AnimatedConfirmationDialog extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;

  const _AnimatedConfirmationDialog({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.onCancel,
    required this.confirmText,
    required this.cancelText,
  });

  @override
  State<_AnimatedConfirmationDialog> createState() =>
      _AnimatedConfirmationDialogState();
}

class _AnimatedConfirmationDialogState
    extends State<_AnimatedConfirmationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.orange[300],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,

            style: getBoldStyle(
                color: AppColors.textColor, fontSize: 22),
          ),
          const SizedBox(height: 12),
          Text(
            widget.message,
            textAlign: TextAlign.center,

            style: getMediumStyle(
              color: AppColors.textColor, fontSize: 16),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.btnColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text(
                  widget.confirmText,
                  style: getSemiBoldStyle(
                      color: AppColors.btnTextColor, fontSize: 14),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (widget.onCancel != null) widget.onCancel!();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text(
                  widget.cancelText,
                  style: getSemiBoldStyle(
                      color: AppColors.btnTextColor, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
