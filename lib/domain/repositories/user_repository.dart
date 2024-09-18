import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import '../../data/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, void>> createUser(UserEntity user);
  Future<Either<Failure, void>> updateUser(UserEntity user);
  Future<Either<Failure, void>> deleteUser(String id);
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, void>> signIn(String email, String password);
}
