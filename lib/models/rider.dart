import 'dart:convert';

class Rider {
  String id;
  String name;
  String phone;
  String email;
  String profileImage;
  String location;
  double latitude;
  double longitude;
  bool isAvailable;
  int completedOrders;
  double rating;

  Rider({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.profileImage,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.isAvailable = true,
    this.completedOrders = 0,
    this.rating = 0.0,
  });

  // Convert JSON to Rider object
  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      profileImage: json['profileImage'] ?? '',
      location: json['location']??'',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      isAvailable: json['isAvailable'] ?? true,
      completedOrders: json['completedOrders'] ?? 0,
      rating: json['rating']?.toDouble() ?? 0.0,
    );
  }

  // Convert Rider object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "email": email,
      "profileImage": profileImage,
      "latitude": latitude,
      "longitude": longitude,
      "isAvailable": isAvailable,
      "completedOrders": completedOrders,
      "rating": rating,
    };
  }
}
