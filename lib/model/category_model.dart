class AllCategoriesModel {
  AllCategoriesModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final bool? status;
  final String? message;
  final List<CategoryModel> data;
  final Pagination? pagination;

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json){
    return AllCategoriesModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<CategoryModel>.from(json["data"]!.map((x) => CategoryModel.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "pagination": pagination?.toJson(),
  };

}

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.status,
  });

  final int? id;
  final String? name;
  int? status;

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
  };

}

class Pagination {
  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.perPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
  });

  final int? currentPage;
  final int? totalPages;
  final int? totalItems;
  final int? perPage;
  final dynamic nextPageUrl;
  final dynamic prevPageUrl;

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      currentPage: json["current_page"],
      totalPages: json["total_pages"],
      totalItems: json["total_items"],
      perPage: json["per_page"],
      nextPageUrl: json["next_page_url"],
      prevPageUrl: json["prev_page_url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "total_pages": totalPages,
    "total_items": totalItems,
    "per_page": perPage,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };

}
