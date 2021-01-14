
import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/data/models/event.dart';
import 'package:event_app/data/models/user.dart';
import 'package:event_app/data/models/user_event_detail.dart';
import 'package:injectable/injectable.dart';

abstract class UserEventDetailRepository {

  Future<Either<Failure,List<UserEventDetail>>> findAll();

  Future<Either<Failure,List<User>>> findAllByEvent_Id(int eventId);

  Future<Either<Failure,List<Event>>> findAllByUser_Id(int userId);

  Future<Either<Failure,UserEventDetail>> findById(int id);

  Future<Either<Failure,UserEventDetail>> add(UserEventDetail userEventDetail);

  Future<Either<Failure,UserEventDetail>> update(int id, UserEventDetail userEventDetail);

  Future<Either<Failure,int>> deleteById(int id);
}
