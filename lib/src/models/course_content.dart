import 'package:myapp/src/models/modules.dart';

class CourseContent {
  int? id;
  String? name;
  int? visible;
  String? summary;
  int? summaryformat;
  int? section;
  int? hidden;
  bool? uservisible;
  List<dynamic>? modules;

  CourseContent(
      {this.id,
      this.name,
      this.visible,
      this.hidden,
      this.section,
      this.summary,
      this.summaryformat,
      this.uservisible,
      this.modules});
  factory CourseContent.fromJson(Map<String, dynamic> json) {
    var modtemp = json['modules'] != null
        ? (json['modules'] as List)
            .map((module) => Module.fromJson(module))
            .toList()
        : <Module>[];
    return CourseContent(
      id: json['id'],
      name: json['name'],
      visible: json['visible'],
      hidden: json['hiddenbynumsections'],
      section: json['section'],
      summary: json['summary'],
      summaryformat: json['summaryformat'],
      uservisible: json['uservisible'],
      modules: modtemp,
    );
  }

  @override
  String toString() {
    return 'id: $id, name: $name, visible: $visible, modules: $modules';
  }
}
