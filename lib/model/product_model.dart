import 'package:chotu_admin/model/category_model.dart';
import 'package:chotu_admin/model/shop_model.dart';

class ProductModel {
  final int id;
  final String name;
  final CategoryModel category;
  final String brand;
  final String price;
  final String discountPrice;
  final String unit;
  final String unitValue;
  final String description;
  final StoreModel store;
  final String img;
   int status;

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

  static ProductModel fromJson(Map<String, dynamic> json) {

      return ProductModel(
        id: json['id'],
        name: json['name'],
        category: CategoryModel.fromJson(json['category']),
        brand: json['brand'],
        price: json['price'],
        discountPrice: json['discount_price'],
        unit: json['unit'],
        unitValue: json['unit_value'],
        description: json['description'],
        store: StoreModel.fromJson(json['store']),
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
