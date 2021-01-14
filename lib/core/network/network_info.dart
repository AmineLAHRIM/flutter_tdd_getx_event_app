import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl() {
    dataConnectionChecker = DataConnectionChecker();
  }

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
