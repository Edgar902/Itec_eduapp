import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  EventState createState() => EventState();
}

Future<Map<DateTime, List<String>>> getEvents() async {
  var url = Uri.parse(
      "https://cuentademo.info/webservice/rest/server.php?wstoken=569b80afd1b69a16bbbce82f2e0995f2&wsfunction=core_calendar_get_calendar_monthly_view&moodlewsrestformat=json&year=2024&month=10");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    Map<DateTime, List<String>> events = {};

    for (var week in data['weeks']) {
      for (var day in week['days']) {
        var days = day['mday'];

        // Verificamos si ese día tiene eventos
        if (day['hasevents'] && day['events'].isNotEmpty) {
          List<String> eventNames = [];

          for (var event in day['events']) {
            eventNames.add(event['name']);
          }

          events[DateTime(2024, 10, days)] =
              eventNames; // Añadimos los eventos a ese día
        }
      }
    }

    return events;
  } else {
    throw Exception('Error al cargar los eventos');
  }
}

class EventState extends State<Events> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Map<DateTime, List<String>> _events = {};
  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    Map<DateTime, List<String>> fetchedEvents = await getEvents();
    setState(() {
      _events = fetchedEvents;
    });
  }

  DateTime removeTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  List<String> _getEventsForDay(DateTime day) {
    DateTime cleanedDay = removeTime(day);
    return _events[cleanedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
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
            TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              eventLoader:
                  _getEventsForDay, // Aquí cargamos los eventos del día seleccionado
            ),
            ..._getEventsForDay(_selectedDay).map((event) => ListTile(
                  title: Text(event),
                )),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _events[_selectedDay]?.length ??
                    0, // Asegúrate de que no sea null
                itemBuilder: (context, index) {
                  final event = _events[_selectedDay]?[index];
                  if (event != null) {
                    return ListTile(
                      title: Text(event),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
