import 'package:flutter/material.dart';
import 'package:myapp/src/widget/WorkTile.dart';

class DetailScreen extends StatelessWidget {
  final String name;

  const DetailScreen({
    super.key,
    required this.name,
  });
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
                name,
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
              Container(
                margin: const EdgeInsets.all(16),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    classCard("General"),
                    classCard("Tema 1"),
                    classCard("Tema 2"),
                    classCard("Tema 3"),
                    classCard("Tema 4"),
                  ],
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
