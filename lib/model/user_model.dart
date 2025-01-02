class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String apiToken;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.apiToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      apiToken: json['api_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}