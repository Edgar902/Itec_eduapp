import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                      color: Color(0xFF19425A),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  padding: const EdgeInsets.all(20.0),
                  child: const Center(
                    child: Text(
                      'Perfil',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Center(
                  child: Text("Alasldas"),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Informacion Personal",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 12.0, top: 12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    color: Colors.orange,
                                    child:
                                        Icon(Icons.email, color: Colors.white),
                                  )),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email",
                                      style: TextStyle(
                                          color: Color(0xFF17202A),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("test200@gmail.com",
                                      style: TextStyle(
                                          color: Color(0xFF17202A),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                ],
                              ),
                            ],
                          )),
                      infoUserCard(Icons.phone, "Celular", "0990143583"),
                      infoUserCard(
                          Icons.calendar_month, "Nacimiento", "11-11-2001"),
                      infoUserCard(Icons.phone, "Celular", "0999999999"),
                    ],
                  ),
                ),
              ],
            ),
            const Positioned.fill(
              top: 100,
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ProfilePicture(
                    name: 'Aditya Dharmawan Saputra',
                    radius: 31,
                    fontsize: 21,
                    random: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget infoUserCard(iconCard, title, name) {
  return SizedBox(
    child: Padding(
        padding: EdgeInsets.only(bottom: 20.0, top: 15.0),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.orange,
                  child: Icon(iconCard, color: Colors.white),
                )),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Color(0xFF17202A),
                        fontWeight: FontWeight.w400,
                        fontSize: 16)),
                SizedBox(
                  width: 5,
                ),
                Text(name,
                    style: TextStyle(
                        color: Color(0xFF17202A),
                        fontWeight: FontWeight.w400,
                        fontSize: 16)),
              ],
            ),
          ],
        )),
  );
}
