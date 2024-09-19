import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/user_repository.dart';

class SignUpCase {
  final UserRepository repository;

  SignUpCase(this.repository);

  Future<Either<Failure, void>> call(UserEntity user) async {
    return await repository.signUp(user);
  }
}
