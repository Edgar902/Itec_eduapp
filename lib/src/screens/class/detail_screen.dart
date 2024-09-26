import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
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
              title: const Text(
                'Detail Screen',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF19425A),
              bottom: const TabBar(
                splashBorderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.cyan,
                labelStyle: TextStyle(color: Colors.white),
                tabs: <Widget>[
                  Tab(text: "topicos", icon: Icon(Icons.favorite)),
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
                    classCard(),
                    classCard(),
                    classCard(),
                    classCard(),
                    classCard(),
                    classCard()
                  ],
                ),
              ),
              Container(child: const Text("asda")),
            ],
          ),
        ));
  }
}

Widget classCard() {
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Desarrollo de Software",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(
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
