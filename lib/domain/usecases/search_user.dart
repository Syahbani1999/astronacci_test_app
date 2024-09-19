import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/user_repository.dart';

class SearchUsers {
  final UserRepository repository;

  SearchUsers(this.repository);

  Future<Either<Failure, List<UserEntity>>> call(String query) async {
    return repository.searchUsers(query);
  }
}
