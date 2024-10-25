class CourseContent {
  int? id;
  String? name;
  int? visible;
  String? summary;
  int? summaryformat;
  int? section;
  int? hidden;
  bool? uservisible;

  CourseContent({
    this.id,
    this.name,
    this.visible,
    this.hidden,
    this.section,
    this.summary,
    this.summaryformat,
    this.uservisible,
  });
  CourseContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    visible = json['visible'];
    hidden = json['hiddenbynumsections'];
    section = json['section'];
    summary = json['summary'];
    summaryformat = json['summaryformat'];
    uservisible = json['uservisible'];
  }

  @override
  String toString() {
    return 'Course id: $id, name: $name, Credits: $visible';
  }
}
