class User {
  final String id;
  final String name;
  final String phoneNumber;
  final Map<String, dynamic>? documents;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.documents,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      documents: json['documents'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'documents': documents,
    };
  }
}