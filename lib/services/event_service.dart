import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/errors.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/repositories/abstract/event_repository.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EventService extends GetxService {
  // this events will be persistane in all the app until the app closed
  var events = RxList<Event>();

  final EventRepository eventRepository;

  EventService(this.eventRepository);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //clearErrors();
    setupEvents();
  }

  // Use Cases
  Future<Either<Failure, Event>> addEvent(Event event) async {
    // TODO: implement add
    var failureOrEvent = await eventRepository.add(event);
    failureOrEvent.fold((failure) => null, (item) => (item) => events.add(item));

    return failureOrEvent;
  }

  List<DateTime> allDates() {
    // TODO: implement allDates
    throw UnimplementedError();
  }

  Future<Either<Failure, int>> deleteEvent(int id) async {
    // TODO: implement deleteById
    var failureOrResult = await eventRepository.deleteById(id);
    failureOrResult.fold((failure) => null, (result) {
      if (result > 0) {
        var index = events.indexWhere((element) => element.id == id);
        if (index != -1) events.removeAt(index);
      }
    });

    return failureOrResult;
  }

  setupEvents() async {
    print('setupEvents');
    // TODO: implement findAll
    var failureOritems = await eventRepository.findAll();
    failureOritems.fold(
      (failure) {
        print('setupEvents failure');

        //messageError.value = MessageError(message: 'Failed Loading Events', type: MessageType.danger);
      },
      (items) {
        print('setupEvents assignAll');
        events.assignAll(items);
      },
    );
  }
}
