import 'package:event_app/core/error/errors.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/repositories/abstract/event_repository.dart';
import 'package:event_app/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeController extends GetxController {
  var events = RxList<Event>();
  var firstNearEvent = Rx<Event>();
  Rx<MessageError> messageError = Rx<MessageError>();

  EventRepository eventRepository;
  EventService eventService;

  HomeController({@required this.eventRepository,@required this.eventService});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    messageError.value = null;
    eventService.onInit();
    setupFirstNear();
  }

  void setupFirstNear() async {
    print('setupFirstNear');
    var failureOrEvents = await this.eventRepository.findAll();
    failureOrEvents.fold(
        (failure) => messageError.value = MessageError(
              message: 'Failed Load Near Event!!',
              type: MessageType.danger,
            ), (events) {

      var nearevent = events.firstWhere((element) => element.near == true);
      if (nearevent != null) {
        print('setupFirstNear result');

        firstNearEvent.value = nearevent;
      } else {
        print('setupFirstNear no result');

        messageError.value = MessageError(
          message: 'No Near Event Right Now!!',
          type: MessageType.danger,
        );
      }
    });
  }
}
