class User {
  String? id;
  String? name;
  String? email;
  String? password;

  User({
    this.id,
    required this.name,
    this.email,
    this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  set setName(String newName) {
    name = newName;
  }

  set setEmail(String newEmail) {
    email = newEmail;
  }

  set setPassword(String newPassword) {
    password = newPassword;
  }
}
