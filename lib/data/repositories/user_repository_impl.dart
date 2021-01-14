import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/data/models/user.dart';
import 'package:event_app/data/repositories/abstract/user_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository{

  @override
  Future<Either<Failure, User>> add(User user) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> deleteById(int id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<User>>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> findById(int id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> update(int id, User user) {
    // TODO: implement update
    throw UnimplementedError();
  }

}