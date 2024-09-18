import 'dart:io';

import 'package:astronacci_test_app/data/datasources/remote_auth_source.dart';
import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../exception.dart';
import '../failure.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteAuthSource remoteAuthSource;
  UserRepositoryImpl({required this.remoteAuthSource});

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    // TODO: implement getCurrentWeather
    try {
      final result = await remoteAuthSource.getUsers();

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> createUser(User user) async {
    try {
      await remoteAuthSource.createUser(UserModel.fromEntity(user));
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure('Failed to add user $error'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(User user) async {
    try {
      await remoteAuthSource.updateUser(UserModel.fromEntity(user));
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure('Failed to update user $error'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await remoteAuthSource.deleteUser(id);
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure('Failed to delete user $error'));
    }
  }
}
