import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/models/user.dart';
import 'package:event_app/data/models/user_event_detail.dart';
import 'package:event_app/data/repositories/abstract/user_event_detail_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserEventDetailRepository)
class UserEventDetailRepositoryImpl implements UserEventDetailRepository{

  @override
  Future<Either<Failure, UserEventDetail>> add(UserEventDetail userEventDetail) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> deleteById(int id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEventDetail>>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<User>>> findAllByEvent_Id(int eventId) {
    // TODO: implement findAllByEvent_Id
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Event>>> findAllByUser_Id(int userId) {
    // TODO: implement findAllByUser_Id
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEventDetail>> findById(int id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEventDetail>> update(int id, UserEventDetail userEventDetail) {
    // TODO: implement update
    throw UnimplementedError();
  }



}