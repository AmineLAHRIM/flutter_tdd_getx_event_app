import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/models/user.dart';

class UserEventDetail {
  int id;
  User user;
  Event event;

  UserEventDetail({this.id, this.user, this.event});

  UserEventDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.event != null) {
      data['event'] = this.event.toJson();
    }
    return data;
  }
}
