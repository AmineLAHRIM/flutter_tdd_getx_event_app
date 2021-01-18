import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @singleton
  DataConnectionChecker get dataConnectionChecker;

  @singleton // if you need to pre resolve the value
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

}