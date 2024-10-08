import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class ForgotPasswordCase {
  final UserRepository repository;

  ForgotPasswordCase(this.repository);

  Future<Either<Failure, void>> call(email) {
    return repository.forgotPassword(email);
  }
}
