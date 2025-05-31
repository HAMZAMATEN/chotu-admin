import 'package:chotu_admin/model/pagination_model.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:flutter/material.dart';


class PaginationButton extends StatelessWidget {
  final PaginationModel pagination;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const PaginationButton({
    Key? key,
    required this.pagination,
    this.onNext,
    this.onPrevious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isFirstPage = pagination.currentPage <= 1;
    final bool isLastPage = pagination.currentPage >= pagination.lastPage;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: isFirstPage ? null : onPrevious,
          style: ElevatedButton.styleFrom(
            backgroundColor: isFirstPage ? Colors.grey : AppColors.primaryColor,
          ),
          child: Text('Previous',
            style:  getMediumStyle(color: Colors.white, fontSize: 16),),
        ),
        const SizedBox(width: 16),
        Text(
          'Page ${pagination.currentPage} of ${pagination.lastPage}',
          style:  getMediumStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: isLastPage ? null : onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: isLastPage ? Colors.grey : AppColors.primaryColor,
          ),
          child:  Text('Next',
            style:  getMediumStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}



class PaginationMoreButton extends StatelessWidget {
  final PaginationModel pagination;
  final VoidCallback? onNext;

  const PaginationMoreButton({
    Key? key,
    required this.pagination,
    this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isFirstPage = pagination.currentPage <= 1;
    final bool isLastPage = pagination.currentPage >= pagination.lastPage;

    return ElevatedButton(
      onPressed: isLastPage ? null : onNext,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLastPage ? Colors.grey : AppColors.primaryColor,
      ),
      child:  Text('More Results',
        style:  getMediumStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
