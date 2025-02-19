import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:chotu_admin/screens/add_properties/add_properties_tab_screen.dart';

import '../../generated/assets.dart';
import '../../providers/add_properties_provider.dart';
import '../../utils/app_Colors.dart';
import '../../utils/app_Paddings.dart';
import '../../utils/app_text_widgets.dart';
import '../../utils/fonts_manager.dart';
import '../../widgets/custom_Button.dart';
import '../../widgets/custom_TextField.dart';

class NewEventsScreen extends StatelessWidget {
  const NewEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<AddPropertiesProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftSection(),
                    SizedBox(
                      width: 40,
                    ),
                    _buildRightSection(provider),
                  ],
                ),
                SizedBox(height: 15),
                Divider(
                  color: AppColors.textFieldBorderColor,
                ),
                SizedBox(height: 15),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        height: 50,
                        width: 150,
                        btnColor: AppColors.primaryColor,
                        btnText: "Submit",
                        btnTextColor: Colors.white,
                        onPress: () => provider.handleEventSubmit(context),
                      ),
                      padding20,
                      CustomButton(
                        height: 50,
                        width: 150,
                        btnColor: AppColors.transparentColor,
                        btnText: "Clear All",
                        btnTextColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                        onPress: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSliderWithValue(double value, double min, double max) {
    return Slider(
      value: value,
      min: min,
      max: max,
      onChanged: (newValue) {},
      activeColor: AppColors.primaryColor,
      inactiveColor: Color(0xffBEC2C7),
    );
  }

  Widget _buildEventButton(String label, {bool isSelected = false}) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 1.5,
              color:
                  isSelected ? AppColors.transparentColor : Color(0xffBEC2C7))),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        label,
        style: getSemiBoldStyle(
          color: isSelected ? Colors.white : Colors.black54,
          fontSize: MyFonts.size12,
        ),
      ),
    );
  }

  Widget _buildLeftSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          padding20,
          Container(
            height: 215,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffF7F7F7),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 94,
                      width: 94,
                      child: Image.asset(Assets.imagesImage)),
                  padding5,
                  Text(
                    'Add Images of events',
                    style: getSemiBoldStyle(
                      color: Color(0xffb0b4be),
                      fontSize: MyFonts.size16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          padding20,
          Row(
            children: [
              Text('Your Ask', style: _sectionHeaderStyle),
              Spacer(),
              Text(
                "600K EVENT",
                style: getSemiBoldStyle(color: Color(0xffEA4649), fontSize: 16),
              ),
            ],
          ),
          _buildSliderWithValue(
            600000,
            0,
            1000000,
          ),
          padding8,
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Down Payment Or Security Deposit',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: _sectionHeaderStyle),
              ),
              padding10,
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "20K EVENT",
                    style: getSemiBoldStyle(
                        color: Color(0xffEA4649), fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          _buildSliderWithValue(20000, 0, 100000),

          padding8,
          // Number Of Rooms

          Row(
            children: [
              Text("Number of Days", style: _sectionHeaderStyle),
              Spacer(),
              Text("4 Days",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
          _buildSliderWithValue(4, 1, 10),
          padding15,
          // Event Type
          Text("Event Types", style: _sectionHeaderStyle),

          padding10,
          Wrap(
            spacing: 10.0,
            runSpacing: 8.0,
            children: [
              _buildEventButton("Music Concert"),
              _buildEventButton("Art Exhibition", isSelected: true),
              _buildEventButton("Tech Conference"),
              _buildEventButton("Food Festival", isSelected: true),
              _buildEventButton("Film Screening"),
              _buildEventButton("Charity Run"),
              _buildEventButton("Networking Meetup"),
              _buildEventButton("Book Launch"),
              _buildEventButton("Stand-up Comedy", isSelected: true),
              _buildEventButton("Christmas Celebration"),
              _buildEventButton("Eid Festival"),
              _buildEventButton("New Year's Party", isSelected: true),
              _buildEventButton("Diwali Celebration"),
              _buildEventButton("Thanksgiving Dinner"),
              _buildEventButton("Hanukkah Gathering"),
              _buildEventButton("Halloween Party"),
              _buildEventButton("Easter Egg Hunt", isSelected: true),
            ],
          ),

          padding15,
          // Charge Type
          Text("How You Charge", style: _sectionHeaderStyle),
          padding10,
          Row(
            children: [
              _buildStatusButton("Per Day", isSelected: true),
              padding20,
              _buildStatusButton("Per Event"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightSection(AddPropertiesProvider provider) {
    return Expanded(
      child: Form(
        key: provider.eventFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
              title: '',
              isBoldHint: true,
              controller: provider.eventNameController,
              focusNode: provider.eventNameFocusNode,
              obscureText: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Enter Event Name";
                }
                return null;
              },
              hintText: "Enter Event Name",
            ),
            CustomTextField(
              title: '',
              isBoldHint: true,
              controller: provider.eventLocationController,
              focusNode: provider.eventLocationFocusNode,
              obscureText: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Enter Event Location";
                }
                return null;
              },
              hintText: "Enter Event Location",
            ),
            CustomTextField(
              title: '',
              isBoldHint: true,
              controller: provider.eventDateController,
              focusNode: provider.eventDateFocusNode,
              obscureText: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Add Event Start Time";
                }
                return null;
              },
              hintText: "Add Event Start Time",
            ),
            CustomTextField(
              title: '',
              isBoldHint: true,
              controller: provider.eventTimeController,
              focusNode: provider.eventTimeFocusNode,
              obscureText: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Add Event Start Date";
                }
                return null;
              },
              hintText: "Add Event Start Date",
            ),
            CustomTextField(
              title: '',
              isBoldHint: true,
              controller: provider.eventDescriptionController,
              focusNode: provider.eventDescriptionFocusNode,
              obscureText: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              minLines: 8,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Add Event Overview";
                }
                return null;
              },
              hintText: "Add Event Overview",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, {bool isSelected = false}) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 1.5,
              color:
                  isSelected ? AppColors.transparentColor : Color(0xffBEC2C7))),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        label,
        style: getSemiBoldStyle(
          color: isSelected ? Colors.white : Colors.black54,
          fontSize: MyFonts.size12,
        ),
      ),
    );
  }
}

final TextStyle _sectionHeaderStyle = getSemiBoldStyle(
  color: AppColors.textColor,
  fontSize: MyFonts.size16,
);
