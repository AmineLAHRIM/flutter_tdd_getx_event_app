import 'dart:convert';

import 'package:event_app/data/datasources/remote/rest_api.dart';
import 'package:event_app/data/models/user.dart';
import 'package:event_app/data/repositories/abstract/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class RemoteUserRepository{
  Future<List<User>> findAll();

  Future<User> findById(int id);

  Future<User> add(User user);

  Future<User> update(int id, User user);

  Future<int> deleteById(int id);
}

@Injectable(as: RemoteUserRepository)
class RemoteUserRepositoryImpl implements RemoteUserRepository {
  @override
  Future<User> add(User user) async {
    // TODO: implement add
    var response = await http.post(RestAPI.URL + '/user/', headers: {'Content-Type': 'application/json'}, body: json.encode(user.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      User newUser = User.fromJson(data);
      return newUser;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<int> deleteById(int id) async {
    // TODO: implement deleteById
    var response = await http.delete(
      RestAPI.URL + '/user/' + id.toString(),
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
  Future<List<User>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<User> findById(int id) async {
    // TODO: implement findById
    var response = await http.get(RestAPI.URL + '/user/' + id.toString());

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      User currentUser = User.fromJson(data);
      return currentUser;
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Future<User> update(int id, User user) async {
    // TODO: implement update
    var response = await http.put(
      RestAPI.URL + '/user/' + id.toString(),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      User newUser = User.fromJson(data);
      return newUser;
    } else {
      throw Exception('No Data Found');
    }
  }
}
