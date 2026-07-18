class User {
  final String username;
  final String phone;
  final String email;
  final String password;

  User({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
  });
}

final users = <User>[];
