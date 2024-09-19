import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import '../../data/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, void>> signUp(UserEntity user);
  Future<Either<Failure, void>> createUser(UserEntity user);
  Future<Either<Failure, void>> updateUser(UserEntity user);
  Future<Either<Failure, void>> deleteUser(String id);
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, List<UserEntity>>> searchUsers(String query);
}
