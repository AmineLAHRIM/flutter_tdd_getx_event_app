import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

@module
abstract class RegisterModule {
  @singleton
  DataConnectionChecker get dataConnectionChecker;

  @singleton
  http.Client get client => http.Client();

  @singleton // if you need to pre resolve the value
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
