import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/src/models/course_content.dart';
import 'package:myapp/src/screens/login/login_screen.dart';
import 'package:myapp/src/widget/WorkTile.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String name;

  const DetailScreen({super.key, required this.id, required this.name});
  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  late Future<List<CourseContent>> courseContentsFuture;
  @override
  void initState() {
    super.initState();
    // Inicializa el Future pasando el ID del curso
    courseContentsFuture = getCourseContents(widget.id);
  }

  static Future<List<CourseContent>> getCourseContents(int courseid) async {
    var token = await getToken();
    var url = Uri.parse(
        "https://cuentademo.info/webservice/rest/server.php?wstoken=$token&wsfunction=core_course_get_contents&moodlewsrestformat=json&courseid=$courseid");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body.map((data) => CourseContent.fromJson(data)).toList();
    } else {
      throw Exception("Error al cargar los contenidos del curso");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              title: Text(
                widget.name,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF19425A),
              bottom: const TabBar(
                splashBorderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                indicatorColor: Colors.cyan,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(color: Colors.cyan),
                tabs: <Widget>[
                  Tab(text: "Modulos", icon: Icon(Icons.favorite)),
                  Tab(text: 'Estudiantes', icon: Icon(Icons.ad_units))
                ],
              )),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FutureBuilder<List<CourseContent>>(
                  future: courseContentsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No hay eventos disponibles.'),
                      );
                    } else {
                      // Si todo está bien, renderizamos la lista de eventos
                      final events = snapshot.data!;
                      return ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return classCard(events[index].name);
                        },
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: const <Widget>[
                    WorkTile(
                        icon: Icons.person,
                        name: "Edgar Andrade",
                        number: "Estudiante No - 1",
                        colors: Colors.red)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Widget classCard(nombre) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.orange,
                      child: const Icon(Icons.add, color: Colors.white),
                    )),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nombre,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
  );
}
