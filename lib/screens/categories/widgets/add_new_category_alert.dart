import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:flutter/material.dart';

import '../../../providers/categories_provider.dart';
import '../../../utils/app_Colors.dart';
import '../../../utils/app_text_widgets.dart';
import '../../../utils/functions.dart';

Future<void> showAddCategoryDialog({
  required BuildContext context,
  required CategoriesProvider provider,
}) async {
  final TextEditingController _categoryNameController = TextEditingController();

  return showDialog(
    context: context,
    builder: (_) => _AnimatedAddCategoryDialog(
      controller: _categoryNameController,
      onConfirm: () async {
        final name = _categoryNameController.text.trim();
        if (name.isNotEmpty) {
          Navigator.of(context).pop();
          await provider.addCategory(name);
        } else {
          AppFunctions.showToastMessage(
              message: "Category name can't be empty");
        }
      },
    ),
  );
}

class _AnimatedAddCategoryDialog extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onConfirm;

  const _AnimatedAddCategoryDialog({
    required this.controller,
    required this.onConfirm,
  });

  @override
  State<_AnimatedAddCategoryDialog> createState() =>
      _AnimatedAddCategoryDialogState();
}

class _AnimatedAddCategoryDialogState extends State<_AnimatedAddCategoryDialog>
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
            child: const Icon(
              Icons.category_outlined,
              size: 60,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Add Category",
            style: getBoldStyle(color: AppColors.textColor, fontSize: 22),
          ),
          const SizedBox(height: 16),
          CustomTextField(
              title: "Category Name",
              controller: widget.controller,
              obscureText: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 3,
              hintText: "Enter category name"),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: widget.onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.btnColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Add",
                  style: getSemiBoldStyle(
                      color: AppColors.btnTextColor, fontSize: 14),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Cancel",
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
