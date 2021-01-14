import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/data/models/ticket.dart';
import 'package:event_app/data/repositories/abstract/ticket_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TicketRepository)
class TicketRepositoryImpl implements TicketRepository{

  @override
  Future<Either<Failure, Ticket>> add(Ticket ticket) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> deleteById(int id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Ticket>>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Ticket>> findById(int id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Ticket>> update(int id, Ticket ticket) {
    // TODO: implement update
    throw UnimplementedError();
  }





}