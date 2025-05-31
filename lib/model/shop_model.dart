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

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'] ?? '',
      fImg: json['f_img'] ?? '',
      cImg: json['c_img'] ?? '',
      categoryId: json['category_id'] ?? 0,
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      status: json['status'] ?? 0,
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

  /// ✅ This returns a List<StoreModel> from a List<dynamic>
  static List<StoreModel> listFromJson(List<dynamic> data) {
    return data.map((item) => StoreModel.fromJson(item as Map<String, dynamic>)).toList();
  }
}
