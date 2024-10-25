class User {
  int? id;
  String? username;
  String? firstname;
  String? lastname;
  String? fullname;
  String? email;
  String? phone;
  String? profileimageurlsmall;
  String? profileimageurl;

  User(
      {required this.id,
      required this.username,
      required this.firstname,
      required this.fullname,
      required this.lastname,
      required this.email,
      required this.phone,
      required this.profileimageurl,
      required this.profileimageurlsmall});

  int? get userId => id;
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone2'],
      profileimageurlsmall: json['profileimageurlsmall'],
      profileimageurl: json['profileimageurl'],
    );
  }
}
