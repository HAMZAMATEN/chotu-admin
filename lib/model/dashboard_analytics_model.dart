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
    required this.shop,
    required this.totalRides,
    required this.totalUsers,
  });

  final int? totalRevenue;
  final int? totalOrders;
  final int? cancelOrders;
  final Shop? shop;
  final int? totalRides;
  final int? totalUsers;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      totalRevenue: json["total_revenue"],
      totalOrders: json["total_orders"],
      cancelOrders: json["cancel_orders"],
      shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
      totalRides: json["total_rides"],
      totalUsers: json["total_users"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total_revenue": totalRevenue,
    "total_orders": totalOrders,
    "cancel_orders": cancelOrders,
    "shop": shop?.toJson(),
    "total_rides": totalRides,
    "total_users": totalUsers,
  };

}

class Shop {
  Shop({
    required this.total,
    required this.active,
    required this.inActive,
  });

  final int? total;
  final int? active;
  final int? inActive;

  factory Shop.fromJson(Map<String, dynamic> json){
    return Shop(
      total: json["total"],
      active: json["active"],
      inActive: json["inActive"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "active": active,
    "inActive": inActive,
  };

}
