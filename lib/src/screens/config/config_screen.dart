import 'package:flutter/material.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

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
                  decoration: BoxDecoration(
                      color: Color(0xFF19425A),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Configuracion',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
                      Text("Cerrar Session")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
