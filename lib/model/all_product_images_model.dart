class AllProductImagesModel {
  AllProductImagesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory AllProductImagesModel.fromJson(Map<String, dynamic> json){
    return AllProductImagesModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.urls,
    required this.count,
  });

  final List<String> urls;
  final int? count;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      urls: json["urls"] == null ? [] : List<String>.from(json["urls"]!.map((x) => x)),
      count: json["count"],
    );
  }

}
