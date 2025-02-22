import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDashboard extends StatefulWidget {
  @override
  State<OrderDashboard> createState() => _OrderDashboardState();
}

class _OrderDashboardState extends State<OrderDashboard> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: Colors.black.withOpacity(.1),
              blurRadius: 2,
              spreadRadius: 0,
            )
          ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Row with Date Range and Branch Selector
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                            ),
                            value: 'All Shops',
                            items: ['All Shops', 'Shop 1', 'Shop 2']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: getMediumStyle(
                                    color: AppColors.textColor,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {}),
                      ),
                      padding12,
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              initialDate: DateTime.now(),
                              initialDatePickerMode: DatePickerMode.day,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );
                            if (selectedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              startDateController.text = formattedDate;
                            }
                          },
                          child: TextFormField(
                            style: getRegularStyle(color: AppColors.textColor),
                            controller: startDateController,
                            autofocus: true,
                            decoration: InputDecoration(
                              label: Text(
                                'Start Date',
                                style:
                                    getRegularStyle(color: AppColors.textColor),
                              ),
                              suffixIcon: const Icon(Icons.calendar_month),
                              hintText: 'dd-mm-yyyy',
                              enabled: false,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      padding12,
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              initialDate: DateTime.now(),
                              initialDatePickerMode: DatePickerMode.day,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );
                            if (selectedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              endDateController.text = formattedDate;
                            }
                          },
                          child: TextFormField(
                            style: getRegularStyle(color: AppColors.textColor),
                            controller: endDateController,
                            autofocus: true,
                            decoration: InputDecoration(
                              label: Text(
                                'End Date',
                                style:
                                    getRegularStyle(color: AppColors.textColor),
                              ),
                              suffixIcon: const Icon(Icons.calendar_month),
                              hintText: 'dd-mm-yyyy',
                              enabled: false,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(231, 234, 243, 1),
                                    width: .6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      padding12,
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Clear Data',
                            style: getRegularStyle(color: AppColors.textColor),
                          ),
                        ),
                      ),
                      padding12,
                      Expanded(
                        child: CustomButton(
                            height: 48,
                            width: double.infinity,
                            btnColor: AppColors.btnColor,
                            btnText: 'Show Data',
                            btnTextColor: AppColors.btnTextColor,
                            onPress: () {}),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Status Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatusCard('Pending', 0, Colors.orange),
                      ),
                      padding12,
                      Expanded(
                        child: _buildStatusCard('Delivered', 0, Colors.green),
                      ),
                      padding12,
                      Expanded(
                        child: _buildStatusCard('Cancelled', 0, Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Search Bar
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 48,
                      width: 300,
                      child: TextFormField(
                        style: getRegularStyle(
                            color: AppColors.textColor, fontSize: 12),
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Search by order id',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(231, 234, 243, 1),
                                width: .6),
                          ),
                          hintStyle: getRegularStyle(
                              color: AppColors.textColor, fontSize: 12),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor, width: .6),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor, width: .6),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor, width: .6),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Scrollable Data Table

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
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xfff5f5f5),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
                  Row(
                    children: [
                      Text(
                        'Order Details',
                        style: getMediumStyle(
                            color: AppColors.textColor, fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        'Delivered',
                        style: getBoldStyle(
                            color: AppColors.primaryColor, fontSize: 16),
                      ),
                    ],
                  ),
                  padding16,
                  _buildRow(title: 'Shops Used', description: '3'),
                  _buildRow(title: 'Products', description: '7'),
                  _buildRow(title: 'Delivery Date', description: '20 Feb 2025'),
                  _buildRow(title: 'Customer', description: 'Customer 1'),
                  _buildRow(title: 'Rider', description: 'Rider 1'),
                  _buildRow(title: 'Shop', description: 'Shop 1'),
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
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getRegularStyle(
              color: const Color(0xff454545),
              fontSize: 14,
            ),
          ),
        ),
        padding12,
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getRegularStyle(
                color: const Color(0xff454545),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
