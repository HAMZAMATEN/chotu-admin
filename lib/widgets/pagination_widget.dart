import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int lastPage;
  final Function(int) onPageSelected;

  const PaginationWidget({
    Key? key,
    required this.currentPage,
    required this.lastPage,
    required this.onPageSelected,
  }) : super(key: key);

  List<Widget> _buildPageButtons() {
    List<Widget> buttons = [];

    for (int i = 1; i <= lastPage; i++) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _buildButton(
            i.toString(),
            i == currentPage,
            () {
              i == currentPage ? null : onPageSelected(i);
            },
          ),
        ),
      );
    }

    return buttons;
  }

  Widget _buildButton(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.btnColor
              : AppColors.btnColor.withOpacity(.7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: getMediumStyle(
            color: AppColors.btnTextColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: _buildPageButtons(),
    );
  }
}
