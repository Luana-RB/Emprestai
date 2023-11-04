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
