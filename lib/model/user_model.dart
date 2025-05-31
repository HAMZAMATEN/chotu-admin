class AllUsersModel {
  AllUsersModel({
    required this.status,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final List<UserModel> data;
  final Pagination? pagination;

  factory AllUsersModel.fromJson(Map<String, dynamic> json){
    return AllUsersModel(
      status: json["status"],
      data: json["data"] == null ? [] : List<UserModel>.from(json["data"]!.map((x) => UserModel.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.map((x) => x?.toJson()).toList(),
    "pagination": pagination?.toJson(),
  };

}

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.city,
    required this.mobileNo,
    required this.email,
    required this.hideUnhide,
    required this.fullAddress,
    required this.lat,
    required this.lng,
    required this.flatSocity,
    required this.flatHouseNo,
    required this.floor,
    required this.password,
    required this.profileImage,
    required this.status,
  });

  final int? id;
  final String? name;
  final String? city;
  final String? mobileNo;
  final String? email;
  final int? hideUnhide;
  final String? fullAddress;
  final String? lat;
  final String? lng;
  final String? flatSocity;
  final String? flatHouseNo;
  final String? floor;
  final String? password;
  final String? profileImage;
  int? status;

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json["id"],
      name: json["name"],
      city: json["city"],
      mobileNo: json["mobile_no"],
      email: json["email"],
      hideUnhide: json["hide_unhide"],
      fullAddress: json["full_address"],
      lat: json["lat"],
      lng: json["lng"],
      flatSocity: json["flat_socity"],
      flatHouseNo: json["flat_house_no"],
      floor: json["floor"],
      password: json["password"],
      profileImage: json["profile_image"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city": city,
    "mobile_no": mobileNo,
    "email": email,
    "hide_unhide": hideUnhide,
    "full_address": fullAddress,
    "lat": lat,
    "lng": lng,
    "flat_socity": flatSocity,
    "flat_house_no": flatHouseNo,
    "floor": floor,
    "password": password,
    "profile_image": profileImage,
    "status": status,
  };

}

class Pagination {
  Pagination({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      total: json["total"],
      perPage: json["per_page"],
      currentPage: json["current_page"],
      lastPage: json["last_page"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
  };

}
