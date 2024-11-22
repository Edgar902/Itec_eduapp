class Module {
  int? id;
  String? name;
  String? url;
  String? modicon;
  String? modname;

  Module({this.id, this.name, this.modname, this.url, this.modicon});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      modname: json['modname'],
      modicon: json['modicon'],
    );
  }
    @override
  String toString() {
    return 'id: $id, name: $name, url: $url, modname: $modname, modicon: $modicon';
  }
}
