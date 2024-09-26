// Suggested code may be subject to a license. Learn more: ~LicenseLog:1971757490.
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:myapp/src/models/Event.dart';
import 'package:table_calendar/table_calendar.dart';

class Events extends StatelessWidget {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectDay;
  Map<DateTime, List<Event>> events = {};
  List<Event> _events = [];
  final DateTime firstDay = DateTime.utc(2010, 10, 16);
  final DateTime lastDay = DateTime.utc(2030, 3, 14);

  Events({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
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
                child: TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: firstDay,
                    lastDay: lastDay))
          ],
        ),
      ),
    );
  }
}
