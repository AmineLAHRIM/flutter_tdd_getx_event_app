import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/data/models/ticket.dart';
import 'package:injectable/injectable.dart';

abstract class TicketRepository {

  Future<Either<Failure,List<Ticket>>> findAll();

  Future<Either<Failure,Ticket>> findById(int id);

  Future<Either<Failure,Ticket>> add(Ticket ticket);

  Future<Either<Failure,Ticket>> update(int id, Ticket ticket);

  Future<Either<Failure,int>> deleteById(int id);
}
