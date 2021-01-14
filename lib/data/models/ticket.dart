class Ticket {
  int id;
  bool deleted;

  Ticket({this.id, this.deleted});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    return data;
  }
}
