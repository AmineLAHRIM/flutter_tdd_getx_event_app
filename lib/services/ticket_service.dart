import 'package:event_app/data/repositories/abstract/ticket_repository.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TicketService extends GetxService{

  TicketRepository ticketRepository;

  TicketService(this.ticketRepository);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}