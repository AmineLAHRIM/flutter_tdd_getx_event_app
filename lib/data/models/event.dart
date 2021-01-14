import 'package:event_app/data/models/ticket.dart';
import 'package:event_app/data/models/user.dart';

class Event{
  int id;
  String name;
  String address;
  DateTime date;
  double price;
  String imageUrl;
  String description;
  bool near;
  bool deleted;
  List<Ticket> tickets;
  List<User> users;

  Event({
    this.id,
    this.name,
    this.address,
    this.date,
    this.price,
    this.imageUrl,
    this.description,
    this.near,
    this.deleted,
    this.tickets,
    this.users,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    date = json['date'] == null ? null : DateTime.parse(json['date'] as String);
    price = (json['price'] as num)?.toDouble();
    imageUrl = json['imageUrl'];
    description = json['description'];
    near = json['near'];
    deleted = json['deleted'];
    if (json['tickets'] != null) {
      tickets = new List<Ticket>();
      json['tickets'].forEach((v) {
        tickets.add(new Ticket.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = new List<User>();
      json['users'].forEach((v) {
        users.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['date'] = this.date;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['near'] = this.near;
    data['deleted'] = this.deleted;
    if (this.tickets != null) {
      data['tickets'] = this.tickets.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
