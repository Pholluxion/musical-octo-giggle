class AuthenticationData {
  final String accessToken;
  final User user;

  AuthenticationData({
    required this.accessToken,
    required this.user,
  });

  factory AuthenticationData.fromJson(Map<String, dynamic> json) {
    return AuthenticationData(
      accessToken: json['accessToken'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String surname;
  final String email;
  final String? password;
  final String documentNumber;
  final int role;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.documentNumber,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
      documentNumber: json['documentNumber'],
      role: json['role'],
    );
  }
}
