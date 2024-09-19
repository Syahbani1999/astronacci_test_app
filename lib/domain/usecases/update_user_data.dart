import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUserDataCase {
  final UserRepository repository;

  UpdateUserDataCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String idUser) async {
    return await repository.updateUserData(idUser);
  }
}
