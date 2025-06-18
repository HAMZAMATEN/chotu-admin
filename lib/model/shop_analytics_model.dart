class StoreAnalyticsModel {
  final int total;
  final int active;
  final int nonActive;

  StoreAnalyticsModel({
    required this.total,
    required this.active,
    required this.nonActive,
  });

  factory StoreAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return StoreAnalyticsModel(
      total: json['total'] ?? 0,
      active: json['active'] ?? 0,
      nonActive: json['non-active'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'active': active,
      'non-active': nonActive,
    };
  }
}
