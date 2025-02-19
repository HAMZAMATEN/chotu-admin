import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/assets.dart';
import '../../../utils/app_Colors.dart';
import '../../../utils/app_Paddings.dart';
import '../../../utils/app_text_widgets.dart';
import '../../../utils/fonts_manager.dart';
import '../../../widgets/custom_Button.dart';

Widget buildPropertyDetailLeftSection() {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 350,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              child: Stack(
                children: [
                  CarouselSlider(
                    items: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          Assets.imagesOverlay,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          Assets.imagesPropertyDetails,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          Assets.imagesOverlay,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 350,
                      viewportFraction: 1,
                      aspectRatio: 1 / 1,
                      autoPlay: true,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.0, right: 10),
                      child: RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        unratedColor: Color(0xffd4d4d4),
                        itemCount: 5,
                        itemSize: 10,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => SvgPicture.asset(
                          Assets.iconsStar,
                          color: Color(0xffFFC700),
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: DotsIndicator(
                        dotsCount: 3,
                        position: 0,
                        decorator: DotsDecorator(
                          color: AppColors.whiteColor, // Inactive color
                          activeColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          padding15,

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Color(0xffC33935),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: Color(0x00000008),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STARTING PRICES',
                    style: getBoldStyle(
                        color: AppColors.whiteColor, fontSize: MyFonts.size16),
                  ),
                  padding10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.iconsMortgage,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          padding5,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type',
                                style: getMediumStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: MyFonts.size10),
                              ),
                              Text(
                                'Villa',
                                style: getMediumStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: MyFonts.size15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.icons003Bed,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          padding5,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bedrooms',
                                style: getMediumStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: MyFonts.size10),
                              ),
                              Text(
                                '6 Bedrooms',
                                style: getMediumStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: MyFonts.size15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  padding10,
                  CustomButton(
                    height: 49,
                    width: double.infinity,
                    btnColor: Colors.transparent,
                    btnText: 'Starting Price : YER 20,000,000',
                    btnTextColor: AppColors.whiteColor,
                    onPress: () {},
                    borderColor: AppColors.whiteColor,
                  ),
                  padding6,
                ],
              ),
            ),
          ),
          padding15,
          // Host Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Color(0xffE5E8EC),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: Color(0x00000008),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MEET YOUR HOST',
                    style: getBoldStyle(
                      fontSize: MyFonts.size16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  padding15,
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 86,
                            width: 86,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: AppColors.textFieldBorderColor,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://images.pexels.com/photos/633432/pexels-photo-633432.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          padding5,
                          Text(
                            'Hassan Haider',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            'Realtor/Hostess',
                            style: getRegularStyle(
                              fontSize: MyFonts.size12,
                              color: Color(0xffB5B8BC),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '591',
                                  style: getRegularStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: MyFonts.size16),
                                ),
                                Text(
                                  'Reviews',
                                  style: getRegularStyle(
                                    color: Color(0xffB5B8BC),
                                    fontSize: MyFonts.size13,
                                  ),
                                ),
                              ],
                            ),
                            padding3,
                            Container(
                              width: 90,
                              height: 1,
                              decoration: BoxDecoration(
                                color: AppColors.textFieldBorderColor,
                              ),
                            ),
                            padding3,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '4.88',
                                  style: getRegularStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: MyFonts.size16),
                                ),
                                Text(
                                  'Rating',
                                  style: getRegularStyle(
                                    color: Color(0xffB5B8BC),
                                    fontSize: MyFonts.size13,
                                  ),
                                ),
                              ],
                            ),
                            padding3,
                            Container(
                              width: 90,
                              height: 1,
                              decoration: BoxDecoration(
                                color: AppColors.textFieldBorderColor,
                              ),
                            ),
                            padding3,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '3 Years',
                                  style: getRegularStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: MyFonts.size16),
                                ),
                                Text(
                                  'Hosting',
                                  style: getRegularStyle(
                                    color: Color(0xffB5B8BC),
                                    fontSize: MyFonts.size13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Hey Everyone, I am your host at this wooden cabin the perfect getaway and enjoy your vacation. I am  ready to serve you and help you as I can',
              style: getRegularStyle(
                fontSize: MyFonts.size12,
                color: AppColors.textColor,
              ),
            ),
          ),
          // Checkout Button

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffE5E8EC),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: Color(0x00000008),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PAYMENT PLAN',
                              style: getBoldStyle(
                                color: AppColors.textColor,
                                fontSize: MyFonts.size16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Attractive 25/75 Post-Handover Payment Plan',
                              style: getRegularStyle(
                                fontSize: MyFonts.size12,
                                color: Color(0xff363C45),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Table(
                        border: TableBorder.symmetric(
                          inside: BorderSide(color: Colors.grey.shade200),
                        ),
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(3),
                        },
                        children: [
                          _buildTableRow('Installment', '%', 'Milestone',
                              isHeader: true),
                          _buildTableRow('Down Payment', '10%', 'On Booking'),
                          _buildTableRow('1st Installment', '10%',
                              'Within 4 months from booking'),
                          _buildTableRow(
                              '2nd Installment', '5%', 'On Handover'),
                          _buildTableRow('3rd Installment', '25%',
                              'Within 12 months from handover'),
                          _buildTableRow('4th Installment', '25%',
                              'Within 24 months from handover'),
                          _buildTableRow('Final Installment', '25%',
                              'Within 36 months from handover'),
                        ],
                      ),
                    ],
                  ),
                ),
                padding20,
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffC39E35),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.iconsDiscount),
                      padding20,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exclusive Realese Offer',
                              style: getBoldStyle(
                                color: Color(0xffC39E35),
                                fontSize: MyFonts.size14,
                              ),
                            ),
                            padding6,
                            Text(
                              '- Get 100% DLD Fees Waiver.\n'
                              '- Pay 75% Over 3 Years After Handover.\n'
                              '- Enjoy 3 Years Service Charge Waiver.Enjoy 3 Years Service Charge Waiver.',
                              style: getRegularStyle(
                                fontSize: MyFonts.size12,
                                color: Color(0xffC39E35),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          padding10,
        ],
      ),
    ),
  );
}

// Helper method to create table rows
TableRow _buildTableRow(String col1, String col2, String col3,
    {bool isHeader = false}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          col1,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
            color: isHeader ? Color(0xff363C45) : AppColors.textColor,
            fontSize: isHeader ? 14 : 10,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          col2,
          style: TextStyle(
            fontWeight:
                isHeader ? FontWeight.w600 : FontWeight.normal, // Highlight %
            color: isHeader ? Color(0xffD32F2F) : Color(0xffEA4649),
            fontSize: isHeader ? 14 : 12,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          col3,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
            color: isHeader ? Color(0xff363C45) : AppColors.textColor,
            fontSize: isHeader ? 14 : 8,
          ),
        ),
      ),
    ],
  );
}
