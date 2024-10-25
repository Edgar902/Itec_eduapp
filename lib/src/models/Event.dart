class Course {
  int? id;
  String? shortname;
  String? fullname;
  String? displayname;
  int? enrolledusercount;
  String? summary;
  String? courseimage;

  Course({
    this.id,
    this.shortname,
    this.fullname,
    this.displayname,
    this.summary,
    this.enrolledusercount,
    this.courseimage,
  });
  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortname = json['shortname'];
    fullname = json['fullname'];
    displayname = json['displayname'];
    summary = json['summary'];
    enrolledusercount = json['enrolledusercount'];
    courseimage = json['courseimage'];
  }
  @override
  String toString() {
    return 'Course id: $id, shortname: $shortname, fullname: $fullname, displayname: $displayname, summary: $summary, enrolledusercount: $enrolledusercount, courseimage: $courseimage';
  }
}
