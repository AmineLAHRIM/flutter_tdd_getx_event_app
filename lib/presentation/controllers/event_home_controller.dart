import 'package:event_app/core/error/errors.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/repositories/abstract/event_repository.dart';
import 'package:event_app/services/event_service.dart';
import 'package:event_app/presentation/state/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class EventHomeController extends GetxController {
  var dates = RxList<DateTime>();

  //var nearEvents=RxList<Event>();
  var nearEventsState = Rx<LoadingState>();

  var currentDataTime = DateTime.now().obs;

  //var messageError=Rx<MessageError>();

  EventRepository eventRepository;

  EventHomeController({@required this.eventRepository});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    setupDates();
    setupNearEvent();
  }

  setupDates() {
    DateTime dateTime = DateTime.now();
    int numberDays = 40;
    if (dates == null || dates.isEmpty) {
      List<DateTime> dateValues = [];
      for (int i = 0; i < numberDays; i++) {
        DateTime currentDateTime = dateTime.add(Duration(days: i - 2));
        dateValues.add(currentDateTime);
      }
      dates.assignAll(dateValues);
    }
  }

  onSelectedDate(DateTime datetime) {
    if (datetime != null) {
      //update datetime
      currentDataTime.value = datetime;

      //filter near events for the same day of the datetime
      setupNearEvent();
    }
  }

  setupNearEvent() async {
    nearEventsState.value = LoadingState.loading();
    print('setupNearEvent');
    var failureOrEvents = await eventRepository.findAll();
    failureOrEvents.fold((failure) {
      print('setupNearEvent failure');

      //messageError.value = MessageError(message: 'Failed Loading Near Events');
      nearEventsState.value = LoadingState.error(message: 'Failed Loading Near Events');
    }, (events) {
      print('setupNearEvent result');

      var list = events.where((element) => element.near == true && isSameDay(element.date)).toList();
      if (list.isEmpty) {
        print('setupNearEvent isEmpty');

        //nearEvents.clear();
        //messageError.value = MessageError(message: 'There is no near event!!');
        nearEventsState.value = LoadingState.empty();

        //nearEventsState.value=LoadingState.EMPTY;
      } else {
        print('setupNearEvent assignAll');
        nearEventsState.value = LoadingState.loaded(value: list);
        Future.delayed(Duration(seconds: 5), () {
          list.add(Event(id: 222,description: 'ddd',address: 'ddd',date: DateTime.now(),name: 'test',imageUrl: 'https://i.ibb.co/wQzSrx0/event7.png'));
          nearEventsState.value=LoadingState.loaded(value: list);
        });
        //nearEvents.assignAll(list);
        //nearEventsState.value=Loaded(object: list);
      }
    });
  }

  bool isSameDay(DateTime dateTime) {
    if (currentDataTime.value == null) {
      return false;
    }
    return currentDataTime.value.year == dateTime.year && currentDataTime.value.month == dateTime.month && currentDataTime.value.day == dateTime.day;
  }
}
