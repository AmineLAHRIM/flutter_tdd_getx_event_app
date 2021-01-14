import 'dart:convert';

import 'package:event_app/data/datasources/remote/rest_api.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/models/user.dart';
import 'package:event_app/data/models/user_event_detail.dart';
import 'package:event_app/data/repositories/abstract/user_event_detail_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class RemoteUserEventDetailRepository{
  Future<List<UserEventDetail>> findAll();

  Future<List<User>> findAllByEvent_Id(int eventId);

  Future<List<Event>> findAllByUser_Id(int userId);

  Future<UserEventDetail> findById(int id);

  Future<UserEventDetail> add(UserEventDetail userEventDetail);

  Future<UserEventDetail> update(int id, UserEventDetail userEventDetail);

  Future<int> deleteById(int id);
}

@Injectable(as: RemoteUserEventDetailRepository)
class RemoteUserEventDetailRepositoryImpl implements RemoteUserEventDetailRepository{

  @override
  Future<UserEventDetail> add(UserEventDetail userEventDetail) async{
    // TODO: implement add
    var response = await http.post(RestAPI.URL + '/userEventDetail/',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userEventDetail.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      UserEventDetail newUserEventDetail = UserEventDetail.fromJson(data);
      return newUserEventDetail;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<int> deleteById(int id) async{
    // TODO: implement deleteById
    var response = await http.delete(
      RestAPI.URL + '/userEventDetail/' + id.toString(),
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
  Future<List<UserEventDetail>> findAll() async{
    // TODO: implement findAll
    var response = await http.get(RestAPI.URL + '/userEventDetail/');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      var items = data.map((e) => UserEventDetail.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<List<User>> findAllByEvent_Id(int eventId) async{
    // TODO: implement findAllByEvent_Id
    var response = await http.get(
        RestAPI.URL + '/userEventDetail/eventId/' + eventId.toString());

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<User> users =
      data.map((e) => UserEventDetail.fromJson(e).user).toList();
      return users;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<List<Event>> findAllByUser_Id(int userId) async{
    // TODO: implement findAllByUser_Id
    var response = await http.get(
        RestAPI.URL + '/userEventDetail/userId/' + userId.toString());

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Event> events =
      data.map((e) => UserEventDetail.fromJson(e).event).toList();
      return events;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<UserEventDetail> findById(int id) async{
    // TODO: implement findById
    var response =
        await http.get(RestAPI.URL + '/userEventDetail/' + id.toString());

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      UserEventDetail currentUserEventDetail = UserEventDetail.fromJson(data);
      return currentUserEventDetail;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<UserEventDetail> update(int id, UserEventDetail userEventDetail) async{
    // TODO: implement update
    var response = await http.put(
      RestAPI.URL + '/userEventDetail/' + id.toString(),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userEventDetail.toJson()),
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      UserEventDetail newUserEventDetail = UserEventDetail.fromJson(data);
      return newUserEventDetail;
    } else {
      throw Exception('No Data Found');
    }
  }

}