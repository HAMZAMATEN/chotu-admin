import 'dart:convert';

class Shop {
  String? id;
  String? sId;
  String? name;
  String? description;
  String? address;
  double? latitude;
  double? longitude;
  String? imageUrl;
  bool? isActive;

  Shop({
    this.id,
    this.name,
    this.description,
    this.address,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.isActive = true,
  });

  //? Convert JSON to Shop Object
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      description:json['description'],
      address: json['address'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      imageUrl: json['imageUrl'],
      isActive: json['isActive'] ?? true,
    );
  }

  //? Convert Shop Object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description":description,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "imageUrl": imageUrl,
      "isActive": isActive,
    };
  }

  //? Convert List of Shops from JSON
  static List<Shop> fromJsonList(String source) {
    Iterable list = json.decode(source);
    return list.map((json) => Shop.fromJson(json)).toList();
  }

  static String toJsonList(List<Shop> shops) {
    return json.encode(shops.map((shop) => shop.toJson()).toList());
  }
}
