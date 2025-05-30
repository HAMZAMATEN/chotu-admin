import 'pagination_model.dart';

class StoreModel {
  int? id;
  String name;
  String fImg;
  String cImg;
  int categoryId;
  String address;
  String latitude;
  String longitude;
  int status;


  StoreModel({
    this.id,
    required this.name,
    required this.fImg,
    required this.cImg,
    required this.categoryId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  static fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      fImg: json['f_img'],
      cImg: json['c_img'],
      categoryId: json['category_id'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'f_img': fImg,
      'c_img': cImg,
      'category_id': categoryId,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }
}
