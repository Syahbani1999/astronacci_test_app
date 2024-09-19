import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignInCase {
  final UserRepository repository;

  SignInCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String username, String password) async {
    return await repository.signIn(username, password);
  }
}
