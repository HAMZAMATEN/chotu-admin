class CategoryModel {
  int? id;
  String name;
  int status;

  CategoryModel({
    this.id,
    required this.name,
    required this.status,
  });

  static fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }
}
