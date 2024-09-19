import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/user_repository.dart';

class GetUsersCase {
  final UserRepository repository;

  GetUsersCase(this.repository);

  Future<Either<Failure, List<UserEntity>>> call(int page, int pageSize) {
    return repository.getUsers(page, pageSize);
  }
}
