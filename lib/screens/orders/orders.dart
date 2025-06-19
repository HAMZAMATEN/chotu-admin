import 'dart:ui';

import 'package:chotu_admin/model/all_orders_model.dart';
import 'package:chotu_admin/providers/orders_provider.dart';
import 'package:chotu_admin/screens/orders/widgets/ShowOrderDetailPopupDialog.dart';
import 'package:chotu_admin/utils/app_Colors.dart';
import 'package:chotu_admin/utils/app_Paddings.dart';
import 'package:chotu_admin/utils/app_text_widgets.dart';
import 'package:chotu_admin/widgets/custom_Button.dart';
import 'package:chotu_admin/widgets/custom_TextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../generated/assets.dart';
import '../../utils/fonts_manager.dart';
import '../../widgets/pagination_widget.dart';
import '../shops/widgets/shop_screen_card_widgets.dart';
import 'orderDetailScreen.dart';

class OrderDashboard extends StatefulWidget {
  @override
  State<OrderDashboard> createState() => _OrderDashboardState();
}

class _OrderDashboardState extends State<OrderDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrdersProvider>(context, listen: false).getOrderAnalytics();
    Provider.of<OrdersProvider>(context, listen: false).getAllStores();
    Provider.of<OrdersProvider>(context, listen: false).getAllOrders(
        storeId: "", storeName: "", startDate: "", endDate: "", page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (context, provider, child) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Header Row with Date Range and Branch Selector

                    provider.allStoresList == null
                        ? Row(
                            children: [
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              padding12,
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              padding12,
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              padding12,
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 46,
                                  child: PopupMenuButton<String>(
                                    color: Colors.white,
                                    shadowColor:
                                        const Color(0xff1F61E0).withOpacity(.3),
                                    elevation: 20,
                                    padding: EdgeInsets.zero,
                                    position: PopupMenuPosition.under,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    onSelected: (value) {
                                      final store = provider.allStoresList!
                                          .firstWhere((e) => e.name == value,
                                              orElse: () => provider
                                                  .allStoresList!.first);
                                      provider.setSelectedStore(
                                          store.id.toString());
                                    },
                                    itemBuilder: provider.allStoresList ==
                                                null ||
                                            provider.allStoresList!.isEmpty
                                        ? (context) => []
                                        : (context) {
                                            return provider.allStoresList!
                                                .map((store) {
                                              return PopupMenuItem<String>(
                                                height: 0,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 12),
                                                value: store.name,
                                                textStyle: getMediumStyle(
                                                  color: AppColors.textColor,
                                                  fontSize: MyFonts.size16,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    provider.selectedStore ==
                                                            store.id.toString()
                                                        ? SvgPicture.asset(
                                                            Assets
                                                                .iconsRadioTrue)
                                                        : SvgPicture.asset(Assets
                                                            .iconsRadioFalse),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      store.name,
                                                      style: getMediumStyle(
                                                        color:
                                                            AppColors.textColor,
                                                        fontSize:
                                                            MyFonts.size16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList();
                                          },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        border: Border.all(
                                          color: AppColors.borderColor,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            () {
                                              if (provider.selectedStore ==
                                                      "0" ||
                                                  provider.selectedStore ==
                                                      null) {
                                                return "All Shops";
                                              }
                                              final selectedStore = provider
                                                  .allStoresList!
                                                  .firstWhere(
                                                    (e) =>
                                                        e.id.toString() ==
                                                        provider.selectedStore,
                                                    orElse: () => provider
                                                        .allStoresList!.first,
                                                  )
                                                  .name;
                                              return selectedStore;
                                            }(),
                                            style: getMediumStyle(
                                              color: AppColors.textColor,
                                              fontSize: MyFonts.size16,
                                            ),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset(
                                              Assets.iconsDropdown),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              padding12,
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      initialDate:
                                          provider.startDate ?? DateTime.now(),
                                      initialDatePickerMode: DatePickerMode.day,
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );
                                    if (selectedDate != null) {
                                      provider.setStartDate(selectedDate);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      style: getMediumStyle(
                                          color: AppColors.textColor),
                                      controller: TextEditingController(
                                          text: provider.formattedStartDate),
                                      decoration: InputDecoration(
                                        label: Text('Start Date',
                                            style: getMediumStyle(
                                                color: AppColors.textColor)),
                                        suffixIcon:
                                            const Icon(Icons.calendar_month),
                                        hintText: 'dd-mm-yyyy',
                                        enabled: false,
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                231, 234, 243, 1),
                                            width: .6,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                231, 234, 243, 1),
                                            width: .6,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                231, 234, 243, 1),
                                            width: .6,
                                          ),
                                        ),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                231, 234, 243, 1),
                                            width: .6,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      initialDate:
                                          provider.endDate ?? DateTime.now(),
                                      initialDatePickerMode: DatePickerMode.day,
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                    );
                                    if (selectedDate != null) {
                                      provider.setEndDate(selectedDate);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      style: getMediumStyle(
                                          color: AppColors.textColor),
                                      controller: TextEditingController(
                                          text: provider.formattedEndDate),
                                      decoration: InputDecoration(
                                        label: Text('End Date',
                                            style: getMediumStyle(
                                                color: AppColors.textColor)),
                                        suffixIcon:
                                            const Icon(Icons.calendar_month),
                                        hintText: 'dd-mm-yyyy',
                                        enabled: false,
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                231, 234, 243, 1),
                                            width: .6,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                231, 234, 243, 1),
                                            width: .6,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                231, 234, 243, 1),
                                            width: .6,
                                          ),
                                        ),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                231, 234, 243, 1),
                                            width: .6,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              padding12,
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    provider.resetFilters();
                                  },
                                  child: Text(
                                    'Clear Data',
                                    style: getRegularStyle(
                                        color: AppColors.textColor),
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
                                  onPress: () {
                                    String storeId =
                                        provider.selectedStore == null ||
                                                provider.selectedStore == "0"
                                            ? ""
                                            : provider.selectedStore.toString();

                                    String storeName = () {
                                      if (provider.selectedStore == "0" ||
                                          provider.selectedStore == null) {
                                        return "All Shops";
                                      }
                                      final selectedStore = provider
                                          .allStoresList!
                                          .firstWhere(
                                            (e) =>
                                                e.id.toString() ==
                                                provider.selectedStore,
                                            orElse: () =>
                                                provider.allStoresList!.first,
                                          )
                                          .name;
                                      return selectedStore;
                                    }();

                                    print("id:::$storeId");
                                    print("name:::$storeName");

                                    provider.getAllOrders(
                                        storeId: storeId,
                                        storeName:
                                            storeName == "All Shops" ? "" : storeName,
                                        startDate: provider.formattedStartDate,
                                        endDate: provider.formattedEndDate,
                                        page: 1);
                                  },
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 16),

                    /// Status Summary Cards

                    provider.ordersAnalyticsModel == null
                        ? Row(
                            children: [
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              padding12,
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              padding12,
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[200]!,
                                  child: Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : _orderStats(provider),

                    /// Search Bar

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            width: MediaQuery.of(context).size.width,
                            title: '',
                            controller: TextEditingController(),
                            obscureText: false,
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.text,
                            hintText: 'Search orders by name and id',
                            suffixIcon: SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(
                                child:
                                    SvgPicture.asset(Assets.iconsSearchnormal1),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Scrollable Data Table

                    Expanded(
                      child: provider.allOrdersList == null
                          ? SingleChildScrollView(
                              child: shimmerOrdersWidget(context))
                          : provider.allOrdersList!.isEmpty
                              ? Center(
                                  child: Text(
                                    "No orders available yet!!",
                                    style: getBoldStyle(
                                      color: AppColors.textColor,
                                      fontSize: 22,
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Wrap(
                                      // alignment: WrapAlignment.center,
                                      // crossAxisAlignment: WrapCrossAlignment.center,
                                      spacing: 16,
                                      runSpacing: 16,
                                      children:
                                          provider.allOrdersList!.map((order) {
                                        return _buildOrderCard(
                                            context, order, provider);
                                      }).toList(),
                                    ),
                                  ),
                                ),
                    ),

                    padding20,
                    PaginationWidget(
                      currentPage: provider.currentPage,
                      lastPage: provider.pagination == null
                          ? 1
                          : provider.pagination!.lastPage ?? 1,
                      onPageSelected: (int selectedPage) {
                        // fetch data for selectedPage
                        print("Go to page $selectedPage");
                        provider.getAllOrders(
                            storeId: "",
                            storeName: "",
                            startDate: "",
                            endDate: "",
                            page: 1);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

  Widget _buildOrderCard(
      BuildContext context, Order order, OrdersProvider provider) {
    return FractionallySizedBox(
      widthFactor: 1 / 3.16,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () => showOrderDetails(context, order),
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
                    'Order No - ${order.id}',
                    style: getMediumStyle(color: Colors.white, fontSize: 16),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 14),
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
                            order.status?.capitalize.toString() ?? "",
                            style: getBoldStyle(
                                color: getStatusColor(order.status),
                                fontSize: 16),
                          ),
                        ],
                      ),
                      padding16,
                      _buildRow(
                          title: 'Shops Used',
                          description: order?.stores.length.toString() ?? "0"),
                      _buildRow(
                          title: 'Products',
                          description: provider
                              .getTotalProductsPurchased(order?.stores ?? [])
                              .toString()),
                      _buildRow(
                          title: 'Delivery Date', description: '20 Feb 2025'),
                      _buildRow(
                          title: 'Customer',
                          description: order?.user?.name ?? ""),
                      _buildRow(
                          title: 'Rider',
                          description: order?.rider?.name ?? ""),
                      padding16,
                      const Divider(
                        color: Color(0xffAFA9A9),
                      ),
                      _buildRow(
                          title: 'Total Billing',
                          description:
                              '${order.billingDetails?.currency ?? "PKR"} ${order.billingDetails?.total ?? "0"}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
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

  Widget _orderStats(OrdersProvider provider) {
    return Row(
      children: [
        Expanded(
          child: _buildStatusCard(
              'All',
              provider.ordersAnalyticsModel!.data?.totalOrders ?? 0,
              Colors.blue),
        ),
        padding12,
        Expanded(
          child: _buildStatusCard(
              'Pending',
              provider.ordersAnalyticsModel!.data?.pendingOrders ?? 0,
              Colors.orange),
        ),
        padding12,
        Expanded(
          child: _buildStatusCard(
              'Delivered',
              provider.ordersAnalyticsModel!.data?.deliveredOrders ?? 0,
              Colors.green),
        ),
        padding12,
        Expanded(
          child: _buildStatusCard(
              'Cancelled',
              provider.ordersAnalyticsModel!.data?.cancelledOrders ?? 0,
              Colors.red),
        ),
      ],
    );
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.primaryColor;
    }
  }

  Widget shimmerOrdersWidget(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: List.generate(10, (index) {
              return buildShimmerShopCardWidget(context);
            }),
          ),
        ],
      ),
    );
  }
}
