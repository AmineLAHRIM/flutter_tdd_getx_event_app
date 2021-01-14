import 'package:event_app/data/models/event.dart';

class User {
  int id;
  String name;
  String imageUrl;
  String geoLocalisation;
  bool deleted;
  List<Event> events;

  User(
      {this.id,
        this.name,
        this.imageUrl,
        this.geoLocalisation,
        this.deleted,
        this.events});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    geoLocalisation = json['geoLocalisation'];
    deleted = json['deleted'];
    if (json['events'] != null) {
      events = new List<Event>();
      json['events'].forEach((v) {
        events.add(new Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['geoLocalisation'] = this.geoLocalisation;
    data['deleted'] = this.deleted;
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
