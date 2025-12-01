import 'package:chotu_admin/providers/side_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../../utils/app_Colors.dart';
import '../../../utils/app_Paddings.dart';
import '../../../utils/app_text_widgets.dart';
import '../../../utils/fonts_manager.dart';
import '../event_detail_screen.dart';

Widget buildEventCard(BuildContext context) {
  return Consumer<SideBarProvider>(
    builder: (context, provider, child) {
      return InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          provider.setScreen(
            EventDetailScreen(),
          );
        },
        child: Container(
          width: 320, // Set a fixed or specific width for the card
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 0.5,
              color: Color(0xffE0E0E0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x29000000),
                // Equivalent to #00000029 (16% opacity)
                offset: Offset(0, 1),
                // Horizontal and vertical offsets (0px, 1px)
                blurRadius: 0.5,
                // Blur radius (0.5px)
                spreadRadius: 0, // Spread radius (0px)
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Image.network(
                          'https://images.pexels.com/photos/1537636/pexels-photo-1537636.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              // Adjusted for text padding
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffEA4649),
                                    Color(0xffF36769),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(
                                    5), // Optional for rounded corners
                              ),
                              child: Text(
                                'Upcoming',
                                style: getSemiBoldStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: MyFonts.size20,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: RatingBar.builder(
                                initialRating: 4,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                unratedColor: Color(0xffd4d4d4),
                                itemCount: 5,
                                itemSize: 10,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => SvgPicture.asset(
                                  Assets.iconsStar,
                                  color: Color(0xffFFC700),
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          color: Color(0xff363C45).withOpacity(0.5),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'Starting YER 1,600,000',
                                style: getMediumStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: MyFonts.size10,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Events',
                                style: getMediumStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: MyFonts.size10,
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event\'s Name',
                      style: getBoldStyle(
                        color: AppColors.textLightColor,
                        fontSize: MyFonts.size12,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        _buildTile(
                            iconPath: Assets.iconsLocation,
                            title: 'Karachi, Pakistan'),
                        Spacer(),
                        _buildTile(
                            iconPath: Assets.icons002Calendar,
                            title: '25/12/2024'),
                      ],
                    ),
                    SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildTile({required String iconPath, required String title}) {
  return Row(
    children: [
      SvgPicture.asset(iconPath),
      padding3,
      Text(
        title,
        style: getSemiBoldStyle(
            color: Color(0xffB0B4BE), fontSize: MyFonts.size10),
      ),
    ],
  );
}
