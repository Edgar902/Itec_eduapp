// Suggested code may be subject to a license. Learn more: ~LicenseLog:1971757490.
import 'package:flutter/material.dart';
import 'package:myapp/src/widget/WorkTile.dart';

class user_screen extends StatelessWidget {
  const user_screen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: ListView(
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
                      Text(
                        'Cronograma',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
            child: ListView(
              children: [
                WorkTile(
                  icon: Icons.book,
                  name: 'Tarea 1',
                  number: '2024-11-20 / 14:00',
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
