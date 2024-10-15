import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/src/models/course.dart';
import 'package:myapp/src/models/course_content.dart';
import 'package:myapp/src/screens/class/detail_screen.dart';
import 'package:myapp/src/widget/WorkTile.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => HomepageState();
}

class HomepageState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
    var datas = Provider.of<UserProvider>(context, listen: false);
    datas.fetchUserData();
  }

  static Future<List<Course>> getCourses() async {
    var url = Uri.parse(
        'https://cuentademo.info/webservice/rest/server.php?wstoken=569b80afd1b69a16bbbce82f2e0995f2&wsfunction=core_enrol_get_users_courses&moodlewsrestformat=json&userid=2');
    var response = await http.get(url);
    final List body = jsonDecode(response.body);

    return body.map((e) => Course.fromJson(e)).toList();
  }

  Future<List<Course>> coursesFuture = getCourses();

  @override
  Widget build(BuildContext context) {
    final name = context.watch<UserProvider>().fullname!;
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        ProfilePicture(
                          name: name,
                          radius: 31,
                          fontsize: 21,
                          random: true,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          name,
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
              child: SizedBox(
                height: 250, // Ajusta la altura según sea necesario
                child: FutureBuilder<List<Course>>(
                  future: coursesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      List<Course> courses = snapshot.data ?? [];

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                // Imagen del curso
                                CachedNetworkImage(
                                  imageUrl: courses[index].courseimage!,
                                  width: 250,
                                  height: double.maxFinite,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                // Gradiente para hacer más legible el texto
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black54
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                // Nombre del curso sobre la imagen
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    courses[index].fullname!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text("No data available");
                    }
                  },
                ),
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

Widget buildCourses(context, List<Courses> courses) {
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
