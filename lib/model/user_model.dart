class UserModel {
   int id;
   String name;
   String city;
   String mobileNo;
   String email;
   int hideUnhide;
   String? fullAddress;
   String lat;
   String lng;
   String? flatSociety;
   String flatHouseNo;
   String floor;
   String password;
   String profileImage;
   int status;

  UserModel({
    required this.id,
    required this.name,
    required this.city,
    required this.mobileNo,
    required this.email,
    required this.hideUnhide,
    this.fullAddress,
    required this.lat,
    required this.lng,
    this.flatSociety,
    required this.flatHouseNo,
    required this.floor,
    required this.password,
    required this.profileImage,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      mobileNo: json['mobile_no'],
      email: json['email'],
      hideUnhide: json['hide_unhide'],
      fullAddress: json['full_address'],
      lat: json['lat'],
      lng: json['lng'],
      flatSociety: json['flat_socity'],
      flatHouseNo: json['flat_house_no'],
      floor: json['floor'],
      password: json['password'],
      profileImage: json['profile_image'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "city": city,
      "mobile_no": mobileNo,
      "email": email,
      "hide_unhide": hideUnhide,
      "full_address": fullAddress,
      "lat": lat,
      "lng": lng,
      "flat_socity": flatSociety,
      "flat_house_no": flatHouseNo,
      "floor": floor,
      "password": password,
      "profile_image": profileImage,
      "status": status,
    };
  }
}
