class UserModel {
  String username;
  String telephone;
  String email;
  String password;
  String profileType;

  UserModel({
    required this.username,
    required this.telephone,
    required this.email,
    required this.password,
    required this.profileType,
  });

  Map<String, dynamic> toMap() {
    return {
      'Username': username,
      'Telephone': telephone,
      'Email': email,
      'Password': password,
      'ProfileType': profileType,
    };
  }
}
