// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../presentation/controllers/event_detail_controller.dart';
import '../presentation/controllers/event_home_controller.dart';
import '../data/repositories/abstract/event_repository.dart';
import '../data/repositories/event_repository_impl.dart';
import '../services/event_service.dart';
import '../presentation/controllers/home_controller.dart';
import '../data/datasources/local/repositories/local_event_repository.dart';
import '../core/network/network_info.dart';
import '../data/datasources/remote/repositories/remote_event_repository.dart';
import '../data/datasources/remote/repositories/remote_ticket_repository.dart';
import '../data/datasources/remote/repositories/remote_user_event_detail_repository.dart';
import '../data/datasources/remote/repositories/remote_user_repository.dart';
import '../data/repositories/abstract/ticket_repository.dart';
import '../data/repositories/ticket_repository_impl.dart';
import '../services/ticket_service.dart';
import '../data/repositories/abstract/user_event_detail_repository.dart';
import '../data/repositories/user_event_detail_repository_impl.dart';
import '../data/repositories/abstract/user_repository.dart';
import '../data/repositories/user_repository_impl.dart';
import '../services/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<LocalEventRepository>(() => LocalEventRepositoryImpl());
  gh.lazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  gh.factory<RemoteEventRepository>(() => RemoteEventRepositoryImpl());
  gh.factory<RemoteTicketRepository>(() => RemoteTicketRepositoryImpl());
  gh.factory<RemoteUserEventDetailRepository>(
      () => RemoteUserEventDetailRepositoryImpl());
  gh.factory<RemoteUserRepository>(() => RemoteUserRepositoryImpl());
  gh.factory<TicketRepository>(() => TicketRepositoryImpl());
  gh.lazySingleton<TicketService>(() => TicketService(get<TicketRepository>()));
  gh.factory<UserEventDetailRepository>(() => UserEventDetailRepositoryImpl());
  gh.factory<UserRepository>(() => UserRepositoryImpl());
  gh.lazySingleton<UserService>(() => UserService(get<UserRepository>()));
  gh.factory<EventRepository>(() => EventRepositoryImpl(
        remoteEventRepository: get<RemoteEventRepository>(),
        localEventRepository: get<LocalEventRepository>(),
        networkInfo: get<NetworkInfo>(),
      ));
  gh.lazySingleton<EventService>(() => EventService(get<EventRepository>()));
  gh.factory<HomeController>(() => HomeController(
      eventRepository: get<EventRepository>(),
      eventService: get<EventService>()));
  gh.factory<EventDetailController>(
      () => EventDetailController(eventRepository: get<EventRepository>()));
  gh.factory<EventHomeController>(
      () => EventHomeController(eventRepository: get<EventRepository>()));
  return get;
}
