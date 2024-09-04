import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Center(
          child: Card(
              margin: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextField(
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: const Text('Login'))
                ]),
              )),
        ));
  }
}

Future login() async {
  try {
    Response response = await get(Uri.parse(
        
        'https://moodle-180896-0.cloudclusters.net/login/token.php?username=admin&password=RkTuO0CL&service=moodle_mobile_app'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['token']);
    }
  } catch (e) {
    print(e.toString());
  }
}
