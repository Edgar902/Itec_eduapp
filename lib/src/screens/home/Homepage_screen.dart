import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:myapp/src/screens/class/detail_screen.dart';
import 'package:myapp/src/widget/WorkTile.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

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
                          'Aditya Dharmawan',
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
                  SizedBox(
                      child: Wrap(
                    children: <Widget>[
                      classCard(context, 'Desarrollo de Software'),
                      classCard(context, 'Mecanica Automotriz'),
                      classCard(context, 'Estetica Integral'),
                      classCard(context, 'Turismo'),
                      classCard(context, 'Diseño Grafico'),
                    ],
                  )),
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
                  ),
                  WorkTile(
                    icon: Icons.book,
                    name: 'Tarea 2',
                    number: '2024-11-22 / 23:00',
                  ),
                  WorkTile(
                    icon: Icons.forum,
                    name: 'Foro',
                    number: '2024-11-23 / 16:30',
                  ),
                  WorkTile(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:824510203.
                    icon: Icons.assessment,
                    name: 'Evaluacion',
                    number: '2024-11-30 / 11:00',
                  ),
                  WorkTile(
                    icon: Icons.book,
                    name: 'Tarea 3',
                    number: '2024-12-01 / 24:00',
                  ),
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
                MaterialPageRoute(builder: (context) => DetailScreen()),
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
