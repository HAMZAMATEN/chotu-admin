class DashboardSettingsModel {
  DashboardSettingsModel({
    required this.status,
    required this.data,
  });

  final bool? status;
  final Data? data;

  factory DashboardSettingsModel.fromJson(Map<String, dynamic> json){
    return DashboardSettingsModel(
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
    required this.id,
    required this.deliveryCharge,
    required this.playStoreLink,
    required this.appStoreLink,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final dynamic deliveryCharge;
  final String? playStoreLink;
  final String? appStoreLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      deliveryCharge: json["delivery_charge"],
      playStoreLink: json["play_store_link"],
      appStoreLink: json["app_store_link"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "delivery_charge": deliveryCharge,
    "play_store_link": playStoreLink,
    "app_store_link": appStoreLink,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}
