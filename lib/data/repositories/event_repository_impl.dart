import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:event_app/core/error/exceptions.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/core/network/network_info.dart';
import 'package:event_app/data/datasources/local/repositories/local_event_repository.dart';
import 'package:event_app/data/datasources/remote/repositories/remote_event_repository.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/repositories/abstract/event_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EventRepository)
class EventRepositoryImpl implements EventRepository {
  final RemoteEventRepository remoteEventRepository;
  final LocalEventRepository localEventRepository;
  final NetworkInfo networkInfo;

  EventRepositoryImpl({
    this.remoteEventRepository,
    this.localEventRepository,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, Event>> add(Event event) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  List<Either<Failure, DateTime>> allDates() {
    // TODO: implement allDates
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> deleteById(int id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Event>>> findAll() async {
    // TODO: implement findAll
    if (await networkInfo.isConnected) {
      try {
        var RemoteEvents = await remoteEventRepository.findAll();
        localEventRepository.cacheAll(RemoteEvents);
        print('TAGG cacheAll');
        return Right(RemoteEvents);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        var localEvents = await localEventRepository.findAll();
        return Right(localEvents);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Event>> findById(int id) async{
    // TODO: implement findById
    if (await networkInfo.isConnected) {
      try {
        var RemoteEvent = await remoteEventRepository.findById(id);
        //localEventRepository.cache(RemoteEvent);
        return Right(RemoteEvent);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        var localEvent = await localEventRepository.findById(id);
        return Right(localEvent);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Event>> update(int id, Event event) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
