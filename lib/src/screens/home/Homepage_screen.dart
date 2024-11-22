import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/src/models/course.dart';

import 'package:myapp/src/models/event.dart';
import 'package:myapp/src/screens/class/detail_screen.dart';
import 'package:myapp/src/screens/login/login_screen.dart';

import 'package:http/http.dart' as http;
import 'package:myapp/src/widget/card_actions.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => HomepageState();
}

class HomepageState extends State<HomePageScreen> {
  static var userToken;
  @override
  void initState() {
    super.initState();

    var datas = Provider.of<UserProvider>(context, listen: false);
    datas.fetchUserData();
  }

  static Future<List<Course>> getCourses() async {
    var token = await getToken();
    userToken = token;
    var url = Uri.parse(
        "https://itecapp.moodlecloud.com/webservice/rest/server.php?wstoken=$token&wsfunction=core_enrol_get_users_courses&moodlewsrestformat=json&userid=2");
    var response = await http.get(url);
    final List body = jsonDecode(response.body);
    return body.map((e) => Course.fromJson(e)).toList();
  }

  static Future<List<Event>> getEvents() async {
    var token = await getToken();
    var url = Uri.parse(
        "https://itecapp.moodlecloud.com/webservice/rest/server.php?wstoken=$token&wsfunction=core_calendar_get_action_events_by_timesort&moodlewsrestformat=json&limitnum=10");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['events'] != null) {
        List eventsData = data['events'];
        return eventsData.map((e) => Event.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Error al obtener los eventos');
    }
  }

  Future<List<Course>> coursesFuture = getCourses();
  Future<List<Event>> eventFuture = getEvents();
  @override
  Widget build(BuildContext context) {
    final name = context.watch<UserProvider>().fullname ?? "";
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
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Cursos",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 250, // Ajusta la altura según sea necesario
                    child: FutureBuilder<List<Course>>(
                      future: coursesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                id: courses[index].id!,
                                                name:
                                                    courses[index].fullname!)));
                                  },
                                  splashColor: Colors.brown.withOpacity(0.5),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Ink(
                                        height: double.maxFinite,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                courses[index].courseimage! +
                                                    "?token=" +
                                                    userToken),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
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
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Eventos",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<List<Event>>(
                      future: eventFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No hay eventos disponibles.'),
                          );
                        } else {
                          // Si todo está bien, renderizamos la lista de eventos
                          final events = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: events.map((event) {
                              return CardActions(
                                  urlIcon: event.iconurl,
                                  name: event.name!,
                                  date: '2024-11-20 / 14:00',
                                  description: event.name!);
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
