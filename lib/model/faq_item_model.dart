class FaqItemModel {
  final int id;
  final String question;
  final String answer;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  FaqItemModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqItemModel.fromJson(Map<String, dynamic> json) {
    return FaqItemModel(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      isActive: json['is_active'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
