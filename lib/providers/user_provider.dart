import 'package:flutter/material.dart';
import 'package:myapp/src/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  int? _id;
  String? _userName;
  String? _firstname;
  String? _lastname;
  String? _fullname;

  int? get id => id;
  String? get userName => _userName;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get fullname => _fullname;
  set userName(String? userName) {
    _userName = userName;
    notifyListeners();
  }

  Future<void> fetchUserData(int id, String token) async {
    final url = Uri.parse(
        'https://cuentademo.info/webservice/rest/server.php?wstoken=$token&wsfunction=core_webservice_get_site_info');
    final response = await http.get(url);
  }

  Future<User> fetchUserFromApi(int id, String token) async {
    final user = await fetchUserData(id, token);
    return User(id: id, name: "Edgar", email: "edgar@gmail.com");
  }
}
