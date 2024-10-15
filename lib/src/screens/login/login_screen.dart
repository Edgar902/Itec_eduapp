import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading ? CircularProgressIndicator() : const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> login(String username, String password) async {
  var url = Uri.parse(
      "https://cuentademo.info/login/token.php?username=$username&password=$password&service=moodle_mobile_app");
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
