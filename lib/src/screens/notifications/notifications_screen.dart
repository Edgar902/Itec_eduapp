// Suggested code may be subject to a license. Learn more: ~LicenseLog:4258285300.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2877141819.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/src/models/notifications.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/src/screens/login/login_screen.dart';

class NotificationsScreen extends StatefulWidget {
  final int id;
  const NotificationsScreen({super.key, required this.id});
  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
  late Future<List<Notifications>> notificationsData;

  @override
  void initState() {
    super.initState();
    // Inicializa el Future pasando el ID del curso
    notificationsData = fetchNotifications(widget.id);
  }

  static Future<List<Notifications>> fetchNotifications(int userid) async {
    var token = await getToken();
    final url = Uri.parse(
      "https://itecapp.moodlecloud.com/webservice/rest/server.php?"
      "wstoken=$token&wsfunction=core_message_get_messages&moodlewsrestformat=json"
      "&useridto=$userid&type=notifications&useridfrom=0&limitnum=4",
    );

    // Realiza la petición
    final response = await http.get(url);

    // Verifica la respuesta
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // Extrae las notificaciones y las convierte en objetos
      return (jsonResponse['messages'] as List)
          .map((message) => Notifications.fromJson(message))
          .toList();
    } else {
      throw Exception("Error al cargar las notificaciones");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: FutureBuilder<List<Notifications>>(
        future: notificationsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay notificaciones.'));
          } else {
            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading:
                        const Icon(Icons.notifications, color: Colors.blue),
                    title: Text(notification.subject!),
                    subtitle: Text(notification.text!,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    onTap: () {
                      // Acción al tocar la notificación
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(notification.subject!),
                          content: Text(notification.text!),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cerrar"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
