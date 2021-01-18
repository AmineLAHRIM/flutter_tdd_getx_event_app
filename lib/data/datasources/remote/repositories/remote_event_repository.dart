
import 'dart:convert';

import 'package:event_app/data/datasources/remote/rest_api.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/repositories/abstract/event_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class RemoteEventRepository{
  Future<List<Event>> findAll();

  Future<Event> firstNear();

  Future<Event> findById(int id);

  Future<Event> add(Event event);

  Future<Event> update(int id, Event event);

  Future<int> deleteById(int id);

  List<DateTime> allDates();
}

@Injectable(as: RemoteEventRepository)
class RemoteEventRepositoryImpl implements RemoteEventRepository{

  http.Client client;


  RemoteEventRepositoryImpl(this.client);

  @override
  Future<Event> add(Event event) async{
    // TODO: implement add
    var response = await http.post(RestAPI.URL + '/event/', headers: {'Content-Type': 'application/json'}, body: json.encode(event.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Event newEvent = Event.fromJson(data);
      return newEvent;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  List<DateTime> allDates() {
    // TODO: implement allDates
    throw UnimplementedError();
  }

  @override
  Future<int> deleteById(int id) async{
    // TODO: implement deleteById
    var response = await http.delete(
      RestAPI.URL + '/event/' + id.toString(),
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
  Future<List<Event>> findAll() async{
    // TODO: implement findAll
    var response = await client.get(RestAPI.URL + '/event/');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      var items = data.map((e) => Event.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<Event> findById(int id) async{
    // TODO: implement findById
    var response = await http.get(RestAPI.URL + '/event/' + id.toString());

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Event currentEvent = Event.fromJson(data);
      return currentEvent;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<Event> firstNear() async{
    // TODO: implement firstNear
    var items=await findAll();
    Event latestEventNear = items.firstWhere((element) => element.near == true);
    return latestEventNear;
  }

  @override
  Future<Event> update(int id, Event event) async{
    // TODO: implement update
    var response = await http.put(RestAPI.URL + '/event/' + id.toString(), headers: {'Content-Type': 'application/json'}, body: json.encode(event.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Event newEvent = Event.fromJson(data);
      return newEvent;
    } else {
      throw Exception('No Data Found');
    }
  }

}