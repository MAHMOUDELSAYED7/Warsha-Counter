class UserModel {
  final String id;
  final String name;
  final String email;
  final int insults;
  final bool isAdmin;
  final bool emailVerified;
  final num topRank;

  UserModel({
    required this.emailVerified,
    required this.id,
    required this.topRank,
    required this.name,
    required this.email,
    required this.insults,
    required this.isAdmin,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      emailVerified: map['emailVerified'] ?? '',
      id: id,
      isAdmin: map['isAdmin'] ?? false,
      topRank: map['topRank'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      insults: map['insults'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailVerified': emailVerified,
      'id': id,
      'name': name,
      'email': email,
      'insults': insults,
      'isAdmin': isAdmin,
    };
  }
}
