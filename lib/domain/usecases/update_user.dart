import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/user_repository.dart';

class UpdateUserCase {
  final UserRepository repository;

  UpdateUserCase(this.repository);

  Future<Either<Failure, void>> call(UserEntity user) async {
    return await repository.updateUser(user);
  }
}
