import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/user_repository.dart';

class DeleteUserCase {
  final UserRepository repository;

  DeleteUserCase(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteUser(id);
  }
}
