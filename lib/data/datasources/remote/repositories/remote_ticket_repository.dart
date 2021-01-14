import 'dart:convert';

import 'package:event_app/data/datasources/remote/rest_api.dart';
import 'package:event_app/data/models/ticket.dart';
import 'package:event_app/data/repositories/abstract/ticket_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class RemoteTicketRepository{
  Future<List<Ticket>> findAll();

  Future<Ticket> findById(int id);

  Future<Ticket> add(Ticket ticket);

  Future<Ticket> update(int id, Ticket ticket);

  Future<int> deleteById(int id);
}

@Injectable(as: RemoteTicketRepository)
class RemoteTicketRepositoryImpl implements RemoteTicketRepository {
  @override
  Future<Ticket> add(Ticket ticket) async {
    // TODO: implement add
    var response = await http.post(RestAPI.URL + '/ticket/', headers: {'Content-Type': 'application/json'}, body: json.encode(ticket.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Ticket newTicket = Ticket.fromJson(data);
      return newTicket;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<int> deleteById(int id) async {
    // TODO: implement deleteById
    var response = await http.delete(
      RestAPI.URL + '/ticket/' + id.toString(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      int data = json.decode(response.body);
      return data;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<List<Ticket>> findAll() async {
    // TODO: implement findAll
    var response = await http.get(RestAPI.URL + '/ticket/');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      var items = data.map((e) => Ticket.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<Ticket> findById(int id) async {
    // TODO: implement findById
    var response = await http.get(RestAPI.URL + '/ticket/' + id.toString());

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Ticket currentTicket = Ticket.fromJson(data);
      return currentTicket;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<Ticket> update(int id, Ticket ticket) async {
    // TODO: implement update
    var response = await http.put(RestAPI.URL + '/ticket/' + id.toString(), headers: {'Content-Type': 'application/json'}, body: json.encode(ticket.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Ticket newTicket = Ticket.fromJson(data);
      return newTicket;
    } else {
      throw Exception('No Data Found');
    }
  }
}
