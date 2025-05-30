class ProductModel {
  final int id;
  final String name;
  final Category category;
  final String brand;
  final String price;
  final String discountPrice;
  final String unit;
  final String unitValue;
  final String description;
  final Store store;
  final String img;
  final int status;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.discountPrice,
    required this.unit,
    required this.unitValue,
    required this.description,
    required this.store,
    required this.img,
    required this.status,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: Category.fromJson(json['category_id']),
      brand: json['brand'],
      price: json['price'],
      discountPrice: json['discount_price'],
      unit: json['unit'],
      unitValue: json['unit_value'],
      description: json['description'],
      store: Store.fromJson(json['store_id']),
      img: json['img'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': category.toJson(),
      'brand': brand,
      'price': price,
      'discount_price': discountPrice,
      'unit': unit,
      'unit_value': unitValue,
      'description': description,
      'store_id': store.toJson(),
      'img': img,
      'status': status,
    };
  }
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Store {
  final String id;
  final String name;

  Store({
    required this.id,
    required this.name,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
