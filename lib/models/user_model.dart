class UserModel {
  final String id;
  final String email;
  final String password; // In a real-world scenario, use a secure method for storing passwords
  final String? token;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
     this.token,
  });

  // Convert User object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'token': token,
    };
  }

  // Create a User object from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      token: json['token'] ?? ''
    );
  }
}
