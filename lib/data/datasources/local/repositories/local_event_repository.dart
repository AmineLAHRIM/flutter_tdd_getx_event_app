import 'dart:convert';
import 'dart:io';

import 'package:event_app/core/error/exceptions.dart';
import 'package:event_app/data/models/event.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_prefs_constant.dart';

abstract class LocalEventRepository {
  /// Gets the cached [List<Event>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<Event>> findAll();

  /// Gets the cached [Event] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<Event> findById(int id);

  /// cache [List<Event>] which was gotten the last time
  /// the user had an internet connection.
  ///
  Future<void> cacheAll(List<Event> events);

  /// cache [Event] which was gotten the last time
  /// the user had an internet connection.
  ///
  Future<void> cache(Event event);
}

@Injectable(as: LocalEventRepository)
class LocalEventRepositoryImpl implements LocalEventRepository {

  LocalEventRepositoryImpl();

  @override
  Future<List<Event>> findAll() async{
    // TODO: implement findAll
    var sharedPreferences=await SharedPreferences.getInstance();

    final jsonString = sharedPreferences.getString(LIST_EVENTS);
    if (jsonString != null) {
      List<dynamic> data = json.decode(jsonString);
      var items = data.map((e) => Event.fromJson(e)).toList();
      return Future.value(items);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAll(List<Event> events) async{
    // TODO: implement cacheAll
    var sharedPreferences=await SharedPreferences.getInstance();
    final jsonString = events.map((e) => e.toJson()).toString();
    print('jsonString' + jsonString);

    return sharedPreferences.setString(
      LIST_EVENTS,
      json.encode(jsonString),
    );
  }

  @override
  Future<Event> findById(int id) async{
    // TODO: implement findById
    var sharedPreferences=await SharedPreferences.getInstance();

    final jsonString = sharedPreferences.getString(EVENT);
    if (jsonString != null) {
      dynamic data = json.decode(jsonString);
      return Future.value(Event.fromJson(data));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cache(Event event) async{
    // TODO: implement cache
    var sharedPreferences=await SharedPreferences.getInstance();

    final jsonString = event.toJson();

    return sharedPreferences.setString(
      EVENT,
      json.encode(jsonString),
    );
  }
}
