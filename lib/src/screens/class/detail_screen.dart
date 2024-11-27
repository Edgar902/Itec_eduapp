import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/src/models/course_content.dart';
import 'package:myapp/src/models/participants.dart';
import 'package:myapp/src/models/user.dart';
import 'package:myapp/src/screens/login/login_screen.dart';
import 'package:myapp/src/widget/WorkTile.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final int id;
  final String name;

  const DetailScreen({super.key, required this.id, required this.name});
  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  late Future<List<CourseContent>> courseContentsFuture;
  late Future<List<User>> courseParticipants;
  List<Item> items = [];
  @override
  void initState() {
    super.initState();
    // Inicializa el Future pasando el ID del curso
    courseContentsFuture = getCourseContents(widget.id);
    courseParticipants = getCourseParticipants(widget.id);
  }

  static Future<List<CourseContent>> getCourseContents(int courseid) async {
    var token = await getToken();
    var url = Uri.parse(
        "https://itecapp.moodlecloud.com/webservice/rest/server.php?wstoken=$token&wsfunction=core_course_get_contents&moodlewsrestformat=json&courseid=$courseid");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);

      return body.map((data) => CourseContent.fromJson(data)).toList();
    } else {
      throw Exception("Error al cargar los contenidos del curso");
    }
  }

  static Future<List<User>> getCourseParticipants(int courseid) async {
    var token = await getToken();
    var url = Uri.parse(
        "https://itecapp.moodlecloud.com/webservice/rest/server.php?wstoken=$token&wsfunction=core_enrol_get_enrolled_users&moodlewsrestformat=json&courseid=$courseid");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);

      return body.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception("Error al cargar los contenidos del curso");
    }
  }

  void prepareItems(List<CourseContent> courseContents) {
    items = courseContents
        .map((content) => Item(
              headerValue: content.name!,
              expandedValue: content.modules!,
              isExpanded: false,
            ))
        .toList();
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
                  Tab(text: "Modulos", icon: Icon(Icons.book)),
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
                      prepareItems(snapshot.data!);
                      return SizedBox(
                        child: SingleChildScrollView(
                          child: ExpansionPanelList.radio(
                            children: items.map<ExpansionPanel>((Item item) {
                              return ExpansionPanelRadio(
                                value:
                                    '${items.indexOf(item)}_${item.headerValue}',
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text(item.headerValue),
                                  );
                                },
                                body: Column(
                                  children: item.expandedValue.isEmpty
                                      ? [
                                          Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "No hay modules disponibles en esta sesccion",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ))
                                        ]
                                      : item.expandedValue.map((info) {
                                          return ListTile(
                                            title: Text(info.name),
                                          );
                                        }).toList(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: FutureBuilder<List<User>>(
                  future: courseParticipants,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('No hay eventos disponibles.'),
                      );
                    } else {
                      // Si todo está bien, renderizamos la lista de eventos
                      final events = snapshot.data!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: events.map((event) {
                          return WorkTile(
                              icon: Icons.abc,
                              name: event.fullname!,
                              number: "",
                              colors: Colors.red);
                        }).toList(),
                      );
                    }
                  },
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

class Item {
  String headerValue;
  List<dynamic> expandedValue;
  bool isExpanded;

  Item({
    required this.headerValue,
    required this.expandedValue,
    this.isExpanded = false,
  });
}
