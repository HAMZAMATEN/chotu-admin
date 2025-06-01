class AllOrdersModel {
  AllOrdersModel({
    required this.status,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final List<Order> data;
  final Pagination? pagination;

  factory AllOrdersModel.fromJson(Map<String, dynamic> json){
    return AllOrdersModel(
      status: json["status"],
      data: json["data"] == null ? [] : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.map((x) => x?.toJson()).toList(),
    "pagination": pagination?.toJson(),
  };

}

class Order {
  Order({
    required this.id,
    required this.user,
    required this.rider,
    required this.stores,
    required this.status,
    required this.createdAt,
  });

  final int? id;
  final Rider? user;
  final Rider? rider;
  final List<StoreElement> stores;
  final String? status;
  final DateTime? createdAt;

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      id: json["id"],
      user: json["user"] == null ? null : Rider.fromJson(json["user"]),
      rider: json["rider"] == null ? null : Rider.fromJson(json["rider"]),
      stores: json["stores"] == null ? [] : List<StoreElement>.from(json["stores"]!.map((x) => StoreElement.fromJson(x))),
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "rider": rider?.toJson(),
    "stores": stores.map((x) => x?.toJson()).toList(),
    "status": status,
    "created_at": createdAt?.toIso8601String(),
  };

}

class Rider {
  Rider({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.profileImage,
    required this.city,
    required this.mobileNo,
    required this.hideUnhide,
    required this.fullAddress,
    required this.location,
    required this.flatSocity,
    required this.flatHouseNo,
    required this.floor,
    required this.lat,
    required this.lng,
    required this.nic,
    required this.gId,
    required this.wallet,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final int? role;
  final int? status;
  final String? profileImage;
  final String? city;
  final String? mobileNo;
  final int? hideUnhide;
  final String? fullAddress;
  final String? location;
  final String? flatSocity;
  final String? flatHouseNo;
  final String? floor;
  final String? lat;
  final String? lng;
  final String? nic;
  final dynamic gId;
  final String? wallet;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Rider.fromJson(Map<String, dynamic> json){
    return Rider(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      status: json["status"],
      profileImage: json["profile_image"],
      city: json["city"],
      mobileNo: json["mobile_no"],
      hideUnhide: json["hide_unhide"],
      fullAddress: json["full_address"],
      location: json["location"],
      flatSocity: json["flat_socity"],
      flatHouseNo: json["flat_house_no"],
      floor: json["floor"],
      lat: json["lat"],
      lng: json["lng"],
      nic: json["nic"],
      gId: json["g_id"],
      wallet: json["wallet"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "status": status,
    "profile_image": profileImage,
    "city": city,
    "mobile_no": mobileNo,
    "hide_unhide": hideUnhide,
    "full_address": fullAddress,
    "location": location,
    "flat_socity": flatSocity,
    "flat_house_no": flatHouseNo,
    "floor": floor,
    "lat": lat,
    "lng": lng,
    "nic": nic,
    "g_id": gId,
    "wallet": wallet,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}

class StoreElement {
  StoreElement({
    required this.store,
    required this.products,
  });

  final StoreStore? store;
  final List<ProductElement> products;

  factory StoreElement.fromJson(Map<String, dynamic> json){
    return StoreElement(
      store: json["store"] == null ? null : StoreStore.fromJson(json["store"]),
      products: json["products"] == null ? [] : List<ProductElement>.from(json["products"]!.map((x) => ProductElement.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "store": store?.toJson(),
    "products": products.map((x) => x?.toJson()).toList(),
  };

}

class ProductElement {
  ProductElement({
    required this.product,
    required this.quantity,
  });

  final ProductProduct? product;
  final int? quantity;

  factory ProductElement.fromJson(Map<String, dynamic> json){
    return ProductElement(
      product: json["product"] == null ? null : ProductProduct.fromJson(json["product"]),
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "quantity": quantity,
  };

}

class ProductProduct {
  ProductProduct({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.brand,
    required this.price,
    required this.discountPrice,
    required this.unit,
    required this.unitValue,
    required this.description,
    required this.storeId,
    required this.img,
    required this.status,
    required this.isSponsored,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? categoryId;
  final String? brand;
  final String? price;
  final String? discountPrice;
  final String? unit;
  final String? unitValue;
  final String? description;
  final String? storeId;
  final String? img;
  final int? status;
  final int? isSponsored;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ProductProduct.fromJson(Map<String, dynamic> json){
    return ProductProduct(
      id: json["id"],
      name: json["name"],
      categoryId: json["category_id"],
      brand: json["brand"],
      price: json["price"],
      discountPrice: json["discount_price"],
      unit: json["unit"],
      unitValue: json["unit_value"],
      description: json["description"],
      storeId: json["store_id"],
      img: json["img"],
      status: json["status"],
      isSponsored: json["is_sponsored"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_id": categoryId,
    "brand": brand,
    "price": price,
    "discount_price": discountPrice,
    "unit": unit,
    "unit_value": unitValue,
    "description": description,
    "store_id": storeId,
    "img": img,
    "status": status,
    "is_sponsored": isSponsored,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

}

class StoreStore {
  StoreStore({
    required this.id,
    required this.name,
    required this.fImg,
    required this.cImg,
    required this.categoryId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? fImg;
  final String? cImg;
  final int? categoryId;
  final String? address;
  final String? latitude;
  final String? longitude;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory StoreStore.fromJson(Map<String, dynamic> json){
    return StoreStore(
      id: json["id"],
      name: json["name"],
      fImg: json["f_img"],
      cImg: json["c_img"],
      categoryId: json["category_id"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "f_img": fImg,
    "c_img": cImg,
    "category_id": categoryId,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
  final String? currentPage;
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
