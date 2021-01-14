import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_app/core/error/failures.dart';
import 'package:event_app/data/models/user.dart';
import 'package:injectable/injectable.dart';

abstract class UserRepository {

  Future<Either<Failure,List<User>>> findAll();

  Future<Either<Failure,User>> findById(int id);

  Future<Either<Failure,User>> add(User user);

  Future<Either<Failure,User>> update(int id, User user);

  Future<Either<Failure,User>> deleteById(int id);
}
