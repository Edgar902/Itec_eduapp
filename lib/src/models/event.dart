import 'package:html/parser.dart';

class Event {
  int? id;
  String? name;
  String? description;
  String? activityname;
  int? timestart;
  int? timesort;
  int? timemodified;
  String? iconurl;
  int? courseid;
  String? fullname;

  String? courseimage;

  Event({
    required this.id,
    this.name,
    this.description,
    this.activityname,
    this.timestart,
    this.timesort,
    this.timemodified,
    this.iconurl,
    this.courseid,
    this.fullname,
  });
  factory Event.fromJson(Map<String, dynamic> json) {
    var desc = json['description'];
    var document = parse(desc);
    var description = document.body!.text;
    return Event(
      id: json['id'],
      name: json['name'],
      description: description,
      activityname: json['activityname'],
      timestart: json['timestart'],
      timesort: json['timesort'],
      timemodified: json['timemodified'],
      iconurl: json['icon']['iconurl'],
      courseid: json['course']['courseid'],
      fullname: json['course']['fullname'],
    );
  }
  @override
  String toString() {
    return 'Event{id: $id, name: $name, description: $description, activityname: $activityname, timestart: $timestart, timesort: $timesort, timemodified: $timemodified, iconurl: $iconurl, courseid: $courseid, fullname: $fullname}';
  }
}
