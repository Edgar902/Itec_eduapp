import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/login/login_screen.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  int? _id;
  String? _userName;
  String? _firstname;
  String? _lastname;
  String? _fullname;
  String? _email;
  String? _phone;
  String? _profileimageurl;
  String? _profileimageurlsmall;

  String? get token => _token;
  int? get id => _id;
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

  void clearUserData() {
    _id = null;
    _userName = null;
    _firstname = null;
    _lastname = null;
    _fullname = null;
    _email = null;
    _phone = null;
    _profileimageurl = null;
    _profileimageurlsmall = null;
  }

  Future<User> fetchUserFromApi() async {
    _token = await getToken();

    var tokenUrl = Uri.parse(
        "https://cuentademo.info/webservice/rest/server.php?wstoken=$_token&wsfunction=core_webservice_get_site_info&moodlewsrestformat=json");
    var res = await http.get(tokenUrl);
    final bodyId = jsonDecode(res.body);
    _id = bodyId['userid'];
    print("id: $_id");
    var url = Uri.parse(
        "https://cuentademo.info/webservice/rest/server.php?wstoken=$_token&wsfunction=core_user_get_users_by_field&field=id&values[0]=$_id&moodlewsrestformat=json");

    var response = await http.get(url);

    final List body = jsonDecode(response.body);

    return User.fromJson(body[0]);
  }
}
