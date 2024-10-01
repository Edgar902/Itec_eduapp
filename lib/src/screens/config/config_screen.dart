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
                  height: 100,
                  decoration: const BoxDecoration(
                      color: Color(0xFF19425A),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  padding: const EdgeInsets.all(20.0),
                  child: const Center(
                    child: Text(
                      'Configuracion',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    color: Colors.blue,
                                    child: const Icon(Icons.language,
                                        color: Colors.white),
                                  )),
                              const SizedBox(
                                width: 12,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Idioma",
                                      style: TextStyle(
                                          color: Color(0xFF17202A),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    color: Colors.blue,
                                    child: const Icon(Icons.notifications_active,
                                        color: Colors.white),
                                  )),
                              const SizedBox(
                                width: 12,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Notificaciones",
                                      style: TextStyle(
                                          color: Color(0xFF17202A),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const Text("Cerrar Session")
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
