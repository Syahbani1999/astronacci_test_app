import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, List<UserEntity>>> call() {
    return repository.getUsers();
  }
}
