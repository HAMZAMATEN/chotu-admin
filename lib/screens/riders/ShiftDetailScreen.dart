import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/side_bar_provider.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';
import '../../utils/fonts_manager.dart';

class ShiftDetailScreen extends StatelessWidget {
  const ShiftDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<SideBarProvider>().goBack();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "John Doe Shift's",
                  style: getBoldStyle(
                    fontSize: MyFonts.size20,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            padding20,
            Wrap(
              // alignment: WrapAlignment.center,
              // crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: List.generate(10, (index) {
                return _buildShiftCard(
                    context,
                    index == 0
                        ? 'Requested'
                        : index == 1
                            ? 'Cancelled'
                            : index == 2
                                ? 'Pending'
                                : 'Completed');
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftCard(BuildContext context, String status) {
    return FractionallySizedBox(
      widthFactor: 1 / 3.16, // Takes 1/3 of the parent width
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 0,
                color: Colors.black.withOpacity(.25)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shift Details',
                style: getMediumStyle(color: AppColors.textColor, fontSize: 16),
              ),
              padding16,
              _buildRow(title: 'Date', description: '2 April'),
              _buildRow(title: 'Shift Time', description: '3 hrs'),
              _buildRow(title: 'Start Time', description: '3:00 PM'),
              _buildRow(title: 'End Time', description: '6:00 PM'),
              _buildRow(title: 'Order Take Time', description: '40 sec'),
              _buildRow(title: 'Order Limit', description: '20'),
              _buildRow(title: 'No break', description: ''),
              _buildRow(title: 'Gulshan Iqbal', description: 'Under 1 km'),
              padding16,
              const Divider(
                color: Color(0xffAFA9A9),
              ),
              _buildRow(title: 'Earning', description: 'Rs. 1000'),
              padding16,
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: status == 'Cancelled'
                      ? Color(0xffBC1C12)
                      : status == 'Pending'
                          ? Colors.purple
                          : status == 'Requested'
                              ? Colors.orange
                              : AppColors.btnColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    status,
                    style: getRegularStyle(
                      color: AppColors.btnTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow({required String title, required String description}) {
    return Row(
      children: [
        Text(
          title,
          style: getRegularStyle(
            color: const Color(0xff454545),
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Text(
          description,
          style: getRegularStyle(
            color: const Color(0xff454545),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
