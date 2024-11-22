import 'package:myapp/src/models/user.dart';

class Participants {
  List<User> users;

  Participants({required this.users});

  factory Participants.fromJson(List<dynamic> json) {
    return Participants(
      users: json.map((user) => User.fromJson(user)).toList(),
    );
  }
  @override
  String toString() {
    return 'user: $users';
  }
}
