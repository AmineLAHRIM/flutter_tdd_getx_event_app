import 'package:event_app/data/models/user.dart';
import 'package:event_app/data/repositories/abstract/user_repository.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserService extends GetxService {
  var currentUser = Rx<User>();
  UserRepository userRepository;

  UserService(this.userRepository);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
