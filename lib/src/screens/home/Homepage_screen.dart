import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:myapp/src/models/course_content.dart';
import 'package:myapp/src/screens/class/detail_screen.dart';
import 'package:myapp/src/widget/WorkTile.dart';
import 'package:http/http.dart' as http;

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => HomepageState();
}

class HomepageState extends State<HomePageScreen> {
  static Future<List<Courses>> getCourses() async {
    var url = Uri.parse(
        'https://cuentademo.info/login/token.php?username=admin&password=Admin_234&service=moodle_mobile_app');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Courses.fromJson(e)).toList();
  }

  Future<List<Courses>> coursesFuture = getCourses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xFF19425A),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                padding: const EdgeInsets.all(20.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        ProfilePicture(
                          name: 'Aditya Dharmawan Saputra',
                          radius: 31,
                          fontsize: 21,
                          random: true,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Edgar Andrade",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    IconButton(onPressed: null, icon: Icon(Icons.notifications))
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Clases', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<List<Courses>>(
                      future: coursesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          final post = snapshot.data;
                          return buildCourses(post!);
                        } else {
                          print("datos snapshot ${snapshot}");
                          return const Text("No data available");
                        }
                      })
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Eventos', style: TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 20,
                  ),
                  WorkTile(
                      icon: Icons.book,
                      name: 'Tarea 1',
                      number: '2024-11-20 / 14:00',
                      colors: Colors.green),
                  WorkTile(
                      icon: Icons.book,
                      name: 'Tarea 2',
                      number: '2024-11-22 / 23:00',
                      colors: Colors.green),
                  WorkTile(
                      icon: Icons.forum,
                      name: 'Foro',
                      number: '2024-11-23 / 16:30',
                      colors: Colors.blue),
                  WorkTile(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:824510203.
                      icon: Icons.assessment,
                      name: 'Evaluacion',
                      number: '2024-11-30 / 11:00',
                      colors: Colors.orange),
                  WorkTile(
                      icon: Icons.book,
                      name: 'Tarea 3',
                      number: '2024-12-01 / 24:00',
                      colors: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget classCard(context, title) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2.5,
    child: Container(
        margin: EdgeInsets.all(10),
        child: MaterialButton(
            height: 120.0,
            minWidth: 150.0,
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(name: title)),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text("A A - 24",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ],
              ),
            ]))),
  );
}

Widget buildCourses(List<Courses> courses) {
  return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Container(
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              SizedBox(width: 10),
              Expanded(flex: 3, child: Text(course.name!)),
            ],
          ),
        );
      });
}
