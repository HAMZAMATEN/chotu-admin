class DashboardAnalyticsModel {
  DashboardAnalyticsModel({
    required this.status,
    required this.data,
  });

  final bool? status;
  final Data? data;

  factory DashboardAnalyticsModel.fromJson(Map<String, dynamic> json){
    return DashboardAnalyticsModel(
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
    required this.totalRevenue,
    required this.totalOrders,
    required this.cancelOrders,
    required this.totalShops,
    required this.totalRides,
    required this.totalUsers,
  });

  final int? totalRevenue;
  final int? totalOrders;
  final int? cancelOrders;
  final int? totalShops;
  final int? totalRides;
  final int? totalUsers;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      totalRevenue: json["total_revenue"],
      totalOrders: json["total_orders"],
      cancelOrders: json["cancel_orders"],
      totalShops: json["total_shops"],
      totalRides: json["total_rides"],
      totalUsers: json["total_users"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total_revenue": totalRevenue,
    "total_orders": totalOrders,
    "cancel_orders": cancelOrders,
    "total_shops": totalShops,
    "total_rides": totalRides,
    "total_users": totalUsers,
  };

}
