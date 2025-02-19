import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/assets.dart';
import '../../../utils/app_Colors.dart';
import '../../../utils/app_Paddings.dart';
import '../../../utils/app_text_widgets.dart';
import '../../../utils/fonts_manager.dart';

Widget buildPropertyDetailRightSection(BuildContext context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Beautiful Wooden Cabin',
                  style: getBoldStyle(
                    fontSize: MyFonts.size18,
                    color: AppColors.textColor,
                  ),
                ),
                padding10,
                Row(
                  children: [
                    SvgPicture.asset(Assets.iconsLocation),
                    padding10,
                    Expanded(
                      child: Text(
                        'Sweden',
                        style: TextStyle(
                            fontSize: MyFonts.size14,
                            color: Color(0xffB0B4BE)),
                      ),
                    ),
                  ],
                ),
                padding10,
                Row(
                  children: [
                    Expanded(
                      child: _buildInfo(
                          iconPath: Assets.iconsMortgage,
                          title: 'Type',
                          subTitle: 'Cabin'),
                    ),
                    Expanded(
                      child: _buildInfo(
                          iconPath: Assets.iconsDirections,
                          title: 'Size',
                          subTitle: '1000 sqm'),
                    ),
                  ],
                ),
                padding15,
                Row(
                  children: [
                    Expanded(
                      child: _buildInfo(
                          iconPath: Assets.icons003Bed,
                          title: 'Bedrooms',
                          subTitle: '6'),
                    ),
                    Expanded(
                      child: _buildInfo(
                          iconPath: Assets.iconsCash,
                          title: 'Down payment',
                          subTitle: '1,000 YER Per Night'),
                    ),
                  ],
                ),
                padding15,

                  Row(
                    children: [
                      Expanded(
                        child: _buildInfo(
                            iconPath: Assets.icons002Key,
                            title: 'Handover',
                            subTitle: 'Feb - 2025'),
                      ),
                      Expanded(
                        child: _buildInfo(
                            iconPath: Assets.icons002Calendar,
                            title: 'Payment Plan',
                            subTitle: '75% over 3 years'),
                      ),
                    ],
                  ),
              ],
            ),
          ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffC39E35),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DLD WAIVER : 100%',
                      style: getBoldStyle(
                        color: Color(0xff363C45),
                        fontSize: MyFonts.size14,
                      ),
                    ),
                    Text(
                      'HomeIN golden bond (from National Bonds)',
                      style: getLightStyle(
                        color: Color(0xffC39E35),
                        fontSize: MyFonts.size14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Overview

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.all(15),
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
                    'Overview',
                    style: getBoldStyle(
                      fontSize: MyFonts.size16,
                      color: AppColors.textColor,
                    ),
                  ),
                  padding8,
                  Text(
                    "While every aspect of the development is organised with keeping in mind about the resident's needs and well-being. It also comes with a spacious basement area boasted with home theatre so you can enjoy with your friends and loved ones, while stay fit with its state of the art gymnasium.",
                    style: getRegularStyle(
                      fontSize: MyFonts.size12,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          padding15,
          // Features and Amenities
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.all(15),
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
                    'FEATURES & AMENITIES',
                    style: getBoldStyle(
                      fontSize: MyFonts.size16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  padding8,
                  Text(
                    "For your benefit, the amenities included in the Blue Views Villansions by Meydan Sobha Group at District are extraordinary and unique.  Every facility that is being offered is meant to give you a sense of exclusiveness. By and large, it will make way for you to lead a hassle-free life in perhaps the best possible way.",
                    style: getRegularStyle(
                      fontSize: MyFonts.size12,
                      color: AppColors.textColor,
                    ),
                  ),
                  padding10,
                  Text(
                    '- Backyard air-conditioned gym\n'
                        '- BBQ swimming pool with wooden deck\n'
                        '- Powerful grid garage windows\n'
                        '- Fireplace\n'
                        '- Central lagoon beachfront\n'
                        '- Jacuzzi\n'
                        '- Sauna\n'
                        '- Kids zone\n'
                        '- Buggy & jogging track',
                    style: getRegularStyle(
                      fontSize: MyFonts.size15,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          padding10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                padding20,
                // Reviews Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Reviews and Ratings',
                    style: getBoldStyle(
                      fontSize: MyFonts.size16,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                padding10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: _buildRatingCard(),
                        );
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

Widget _buildRatingCard() {
  return Container(
    padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 70),
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
        Row(
          children: [
            RatingBar.builder(
              initialRating: 4,
              minRating: 1,
              itemSize: 12,
              direction: Axis.horizontal,
              allowHalfRating: false,
              unratedColor: Color(0xffd4d4d4),
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => Container(
                height: 12,
                width: 12,
                child: Center(
                  child: SvgPicture.asset(
                    Assets.iconsStar,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              onRatingUpdate: (rating) {},
            ),
            padding10,
            Text(
              '1 week ago',
              style: getSemiBoldStyle(
                  color: AppColors.textColor, fontSize: MyFonts.size16),
            ),
          ],
        ),
        padding10,
        Text(
          'I really enjoyed staying at your beautiful cabin in the mountains. It was a joy to watch it snowing. The view of amazing perfect for a vacation ',
          style: getRegularStyle(
            fontSize: MyFonts.size12,
            color: AppColors.textColor,
          ),
        ),
        padding10,
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/29757529/pexels-photo-29757529/free-photo-of-silhouette-of-woman-against-ornate-yellow-glass.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            padding10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lindsey',
                  style: getSemiBoldStyle(
                      color: AppColors.textColor, fontSize: MyFonts.size12),
                ),
                Text(
                  'Birmigham, United Kingdom',
                  style: getRegularStyle(
                      color: AppColors.textColor, fontSize: MyFonts.size10),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}



Widget _buildInfo(
    {required String iconPath,
      required String title,
      required String subTitle}) {
  return Row(
    children: [
      Container(
        height: 18,
        width: 18,
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            color: Color(0xff363C45),
          ),
        ),
      ),
      padding5,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getMediumStyle(
                  color: Color(0xffB0B4BE), fontSize: MyFonts.size10),
            ),
            Text(
              subTitle,
              style: getMediumStyle(
                color: Color(0xff363C45),
                fontSize: MyFonts.size14,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}