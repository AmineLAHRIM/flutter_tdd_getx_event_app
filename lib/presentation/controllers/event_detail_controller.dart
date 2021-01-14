import 'package:event_app/core/error/errors.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/models/user.dart';
import 'package:event_app/data/repositories/abstract/event_repository.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class EventDetailController extends GetxController {
  var currentEvent=Rx<Event>();
  var messageError=Rx<MessageError>();
  var currentUsers=RxList<User>();
  var isLoading = true.obs;

  EventRepository eventRepository;

  EventDetailController({this.eventRepository});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  setupCurrentEvent(int id) async {
    print('setupCurrentEvent '+id.toString());
    var failureOrEvent = await eventRepository.findById(id);
    failureOrEvent.fold(
        (failure) {
          print('setupCurrentEvent failure');

          messageError.value = MessageError(
            message: 'Failed Loading Current Event!!',
            type: MessageType.danger,
          );
        },
        (event) {
          print('setupCurrentEvent result '+event.name.toString());

          currentEvent.value = event;
        });
  }
}
