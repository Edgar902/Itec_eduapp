import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      String? token = await login(username, password);
      if (token != null) {
        await saveToken(token);
        Provider.of<UserProvider>(context, listen: false).clearUserData();

        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      print('Erro de inicion de sesion: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/logo-gris-web.png', width: 100)],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Iniciar Sesion",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextField(
                          autofocus: false,
                          controller: _usernameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Usuario',
                              prefixIcon: Icon(Icons.person),
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextField(
                          autofocus: false,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Contrasena',
                              prefixIcon: Icon(Icons.lock),
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : const Text('Ingresar'),
            ),

                    ],
                  )),
            )
          ],
        ));
  }
}

Future<String?> login(String username, String password) async {
  var url = Uri.parse(
      "https://cuentademo.info/login/token.php?username=$username&password=$password&service=itec_api");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data.containsKey('token')) {
      return data['token'];
    } else {
      throw Exception('Credenciales Incorrectas');
    }
  } else {
    throw Exception('Error en el servidor');
  }
}

Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_token', token);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_token');
}

Future<void> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_token');
}
