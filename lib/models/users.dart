class User{
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isActive;
  final String lastActive;
  final String feedback;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
    required this.lastActive,
    required this.feedback,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      isActive: json['isActive'],
      lastActive: json['lastActive'],
      feedback: json['feedback'] ?? '',
    );
  }
}
