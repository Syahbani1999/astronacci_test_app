import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class ForgotPassword {
  final UserRepository repository;

  ForgotPassword(this.repository);

  Future<Either<Failure, void>> call(email) {
    return repository.forgotPassword(email);
  }
}
