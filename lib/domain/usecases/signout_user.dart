import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/user_repository.dart';

class SignOutCase {
  final UserRepository repository;

  SignOutCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.loggedOut();
  }
}
