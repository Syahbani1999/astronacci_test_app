import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import '../../data/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
