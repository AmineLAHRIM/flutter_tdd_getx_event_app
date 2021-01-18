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
  Future<bool> cacheAll(List<Event> events);

  /// cache [Event] which was gotten the last time
  /// the user had an internet connection.
  ///
  Future<bool> cache(Event event);
}

@Injectable(as: LocalEventRepository)
class LocalEventRepositoryImpl implements LocalEventRepository {
  SharedPreferences sharedPreferences;

  LocalEventRepositoryImpl(this.sharedPreferences);

  @override
  Future<List<Event>> findAll() async {
    // TODO: implement findAll

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
  Future<bool> cacheAll(List<Event> events) async {
    // TODO: implement cacheAll
    var jsonData= events.map((v) => v.toJson()).toList();

    return sharedPreferences.setString(
      LIST_EVENTS,
      json.encode(jsonData),
    );
  }

  @override
  Future<Event> findById(int id) async {
    // TODO: implement findById

    final jsonString = sharedPreferences.getString(EVENT + id.toString());
    if (jsonString != null) {
      dynamic data = json.decode(jsonString);
      return Future.value(Event.fromJson(data));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cache(Event event) async {
    // TODO: implement cache
    final jsonString = event.toJson();
    return sharedPreferences.setString(
      EVENT + event.id.toString(),
      json.encode(jsonString),
    );
  }
}
