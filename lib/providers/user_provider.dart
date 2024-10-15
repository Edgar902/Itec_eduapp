import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  int? _id;
  String? _userName;
  String? _firstname;
  String? _lastname;
  String? _fullname;
  String? _email;
  String? _phone;
  String? _profileimageurl;
  String? _profileimageurlsmall;

  int? get id => id;
  String? get userName => _userName;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get fullname => _fullname;
  String? get email => _email;
  String? get phone => _phone;
  String? get profileimageurl => _profileimageurl;
  String? get profileimageurlsmall => _profileimageurlsmall;
  set userName(String? userName) {
    _userName = userName;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    final fetchUser = await fetchUserFromApi();
    _id = fetchUser.id;
    _userName = fetchUser.username;
    _firstname = fetchUser.firstname;
    _lastname = fetchUser.lastname;
    _fullname = fetchUser.fullname;
    _email = fetchUser.email;
    _phone = fetchUser.phone;
    _profileimageurl = fetchUser.profileimageurl;
    _profileimageurlsmall = fetchUser.profileimageurlsmall;
    notifyListeners();
  }

  Future<User> fetchUserFromApi() async {
    var url = Uri.parse(
        'https://cuentademo.info/webservice/rest/server.php?wstoken=569b80afd1b69a16bbbce82f2e0995f2&wsfunction=core_user_get_users_by_field&field=id&values[0]=2&moodlewsrestformat=json');
    var response = await http.get(url);
    final List body = jsonDecode(response.body);

    return User.fromJson(body[0]);
  }
}
