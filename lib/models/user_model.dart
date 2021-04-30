class User {
  String email;
  String userName;
  String role;

  User({this.email, this.role, this.userName});

  Map<String, dynamic> toMap() {
    return {'email': email, 'userName': userName, 'role': role};
  }

  User.fromMap(Map<String, dynamic> map)
      : userName = map['userName'],
        email = map['email'],
        role = map['role'];
}
