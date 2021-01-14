import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/data/models/event.dart';

abstract class EventRepository {

  Future<Either<Failure, List<Event>>> findAll();

  Future<Either<Failure,Event>> findById(int id);

  Future<Either<Failure,Event>> add(Event event);

  Future<Either<Failure,Event>> update(int id, Event event);

  Future<Either<Failure,int>> deleteById(int id);

  List<Either<Failure,DateTime>> allDates();
}
