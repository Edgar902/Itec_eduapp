class Courses {
  int? id;
  String? name;
  int? visible;
  String? summary;
  int? summaryformat;
  int? section;
  int? hidden;
  bool? uservisible;

  Courses({
    this.id,
    this.name,
    this.visible,
    this.hidden,
    this.section,
    this.summary,
    this.summaryformat,
    this.uservisible,
  });
  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    visible = json['visible'];
    hidden = json['hiddenbynumsections'];
    section = json['section'];
    summary = json['summary'];
    summaryformat = json['summaryformat'];
    uservisible = json['uservisible'];
  }
}
