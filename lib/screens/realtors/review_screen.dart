import 'package:chotu_admin/providers/side_bar_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';
import '../../utils/fonts_manager.dart';
import '../../widgets/custom_Button.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Realtor Reviews and Rating',
                        style: getBoldStyle(
                          fontSize: MyFonts.size20,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  padding20,
                  ListView.builder(
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
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 360,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // User Image
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/29757529/pexels-photo-29757529/free-photo-of-silhouette-of-woman-against-ornate-yellow-glass.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                      ),
                      padding5,
                      // User Name and Role
                      Text(
                        "Hassan Ali",
                        style:
                            getMediumStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        "Realtor/Hostess",
                        style: getRegularStyle(
                          fontSize: 15,
                          color: Color(0xffB5B8BC),
                        ),
                      ),
                      padding20,
                      // User Information
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffFDFDFD),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4)),
                            ],
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            )),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Realtor Information',
                              style: getBoldStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                            padding10,
                            buildInfoRow("Currently Listed Properties", "57"),
                            buildInfoRow("Sold Properties", "0"),
                            buildInfoRow(
                                "Rented Properties (Short Term)", "2,326"),
                            buildInfoRow(
                                "Rented Properties (Long Term)", "1,326"),
                            buildInfoRow("All Time Listed Properties", "3,326"),
                            padding10,
                            Text(
                              'Overall Ratings',
                              style: getRegularStyle(
                                  fontSize: 14, color: Color(0xff7D7F88)),
                            ),
                            padding10,
                            Container(
                              height: 25,
                              child: RatingBar.builder(
                                initialRating: 4,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                unratedColor: Color(0xffd4d4d4),
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => SvgPicture.asset(
                                  Assets.iconsStar,
                                  color: Color(0xffFFC700),
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            padding15,
                          ],
                        ),
                      ),
                      padding10,
                      // User Joining Date
                      Text(
                        "Joined at 14/12/2024 and is a frequent poster",
                        style: getMediumStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding15,
                      // Action Buttons

                      CustomButton(
                        height: 50,
                        width: double.infinity,
                        btnColor: AppColors.primaryColor,
                        btnText: 'Contact',
                        btnTextColor: Colors.white,
                        onPress: () {},
                      ),

                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Ban Profile",
                          style: getMediumStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getRegularStyle(fontSize: 14, color: Color(0xff7D7F88)),
          ),
          Text(
            value,
            style: getMediumStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
