class OrdersAnalyticsModel {
  OrdersAnalyticsModel({
    required this.status,
    required this.data,
  });

  final bool? status;
  final Data? data;

  factory OrdersAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return OrdersAnalyticsModel(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.totalOrders,
    required this.pendingOrders,
    required this.cancelledOrders,
    required this.deliveredOrders,
  });

  final int? totalOrders;
  final int? pendingOrders;
  final int? cancelledOrders;
  final int? deliveredOrders;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      totalOrders: json["total_orders"],
      pendingOrders: json["pending_orders"],
      cancelledOrders: json["cancelled_orders"],
      deliveredOrders: json["delivered_orders"],
    );
  }

  Map<String, dynamic> toJson() => {
        "total_orders": totalOrders,
        "pending_orders": pendingOrders,
        "cancelled_orders": cancelledOrders,
        "delivered_orders": deliveredOrders,
      };
}
