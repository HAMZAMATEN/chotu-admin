import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 5,
        ),
        child: Column(
          children: [
            padding30,
            _buildTopSection(),
            padding20,
            Row(
              children: [
                // Users Detail
                Expanded(
                  child: _buildPieChart("Users Detail", {
                    Color(0xffFF4D4D): 'Buyer/Renters', // Buyer/Renters
                    Color(0xff22C55E): 'Realtors', // Realtors
                    Color(0xffC084FC): 'Hostess', // Hostess
                  }),
                ),
                padding20,
                // Buyer's Info
                Expanded(
                  child: _buildPieChart("Buyer's Info", {
                    Color(0xffFF4D4D): 'Want to Rent', // Want to Rent
                    Color(0xffC084FC): 'Want to Own', // Want to Own
                  }),
                ),
                padding20,

                // Realtor's Info
                Expanded(
                  child: _buildPieChart("Realtor's Info", {
                    Color(0xffFF4D4D): 'Give to Rent', // Give to Rent
                    Color(0xffC084FC): 'Want to Sell', // Want to Sell
                  }),
                ),
              ],
            ),
            padding20,
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Row(
      children: [
        Expanded(
          child: _buildTopCard(
              imgPath: Assets.iconsRevenue,
              title: 'Revenue',
              amount: '166,580',
              increase: '5%'),
        ),
        padding30,
        Expanded(
          child: _buildTopCard(
              imgPath: Assets.iconsProduct,
              title: 'Product Sold',
              amount: '5,679',
              increase: '2%'),
        ),
        padding30,
        Expanded(
          child: _buildTopCard(
              imgPath: Assets.iconsCustomer,
              title: 'Customers',
              amount: '51,580',
              increase: '4%'),
        ),
      ],
    );
  }

  Widget _buildTopCard({
    required String imgPath,
    required String title,
    required String amount,
    required String increase,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffD9D9D9))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 24,
                child: Center(child: Image.asset(imgPath)),
              ),
              padding5,
              Text(
                title,
                style: getRegularStyle(
                  color: Color(0xff1f1f1f),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          padding10,
          Text(
            '$amount YER',
            style: getMediumStyle(color: Color(0xff1f1f1f), fontSize: 32),
          ),
          padding10,
          Row(
            children: [
              Container(
                height: 24,
                width: 24,
                child: Center(
                  child: SvgPicture.asset(
                    Assets.iconsTrendup,
                  ),
                ),
              ),
              Text(
                increase,
                style: getMediumStyle(
                  color: Color(0xffFF4D4D),
                  fontSize: 16,
                ),
              ),
              Text(
                ' in the last 1 month',
                style: getRegularStyle(
                  color: Color(0xffABABAB),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(String title, Map<Color, String> data) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffD9D9D9))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          padding8,
          Row(
            children: [
              Container(
                height: 150,
                width: 150,
                child: PieChart(
                  PieChartData(
                    sections: data.entries
                        .map(
                          (entry) => PieChartSectionData(
                            color: entry.key,
                            titleStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        .toList(),
                    sectionsSpace: 4,
                    centerSpaceRadius: 30,
                  ),
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.entries.map((e) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 27,
                          width: 27,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: e.key),
                        ),
                        padding5,
                        Text(
                          e.value,
                          style: getRegularStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
