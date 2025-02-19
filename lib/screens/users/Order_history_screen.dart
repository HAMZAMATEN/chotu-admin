import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/side_bar_provider.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';
import '../../utils/fonts_manager.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

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
                  "Order's History",
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
                return _buildOrderCard(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1 / 3.16, // Takes 1/3 of the parent width
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 7,
              spreadRadius: 0,
              color: Colors.black.withOpacity(.25)),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 51,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff45CF8D),
                    Color(0xff046938),
                  ],
                ),
              ),
              child: Center(
                  child: Text(
                'Order No - xxxxx',
                style: getMediumStyle(color: Colors.white, fontSize: 16),
              )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Details',
                    style: getMediumStyle(
                        color: AppColors.textColor, fontSize: 16),
                  ),
                  padding16,
                  _buildRow(title: 'Shops Used', description: '3'),
                  _buildRow(title: 'Products', description: '7'),
                  _buildRow(title: 'Voices', description: '2'),
                  _buildRow(title: 'Messages', description: '8'),
                  _buildRow(title: 'Live Commerce', description: '100 PKR'),
                  _buildRow(title: 'E-Commerce', description: '100 PKR'),
                  padding16,
                  const Divider(
                    color: Color(0xffAFA9A9),
                  ),
                  _buildRow(title: 'Total Billing', description: 'Rs. 394'),
                ],
              ),
            ),
          ],
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
