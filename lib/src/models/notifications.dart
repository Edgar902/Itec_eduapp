import 'package:flutter/material.dart';

class Notifications {
  int? id;
  String? subject;
  String? text;
  int? timecreated;
  int? useridfrom;
  int? useridto;

  Notifications({
    this.id,
    this.subject,
    this.text,
    this.timecreated,
    this.useridfrom,
    this.useridto,
  });
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      subject: json['subject'],
      text: json['text'],
      timecreated: json['timecreated'],
      useridfrom: json['useridfrom'],
      useridto: json['useridto'],    
    );
  }
  @override
  String toString() {
    return 'Notification(id: $id, subject: $subject, text: $text)';
  }
}
