import 'dart:io';

import 'package:astronacci_test_app/data/datasources/remote_auth_source.dart';
import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../exception.dart';
import '../failure.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteAuthSource remoteAuthSource;
  UserRepositoryImpl({required this.remoteAuthSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
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
  Future<Either<Failure, void>> createUser(UserEntity user) async {
    try {
      await remoteAuthSource.signUp(UserModel.fromEntity(user));
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure('Failed to add user $error'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity user) async {
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

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    // TODO: implement forgotPassword
    try {
      await remoteAuthSource.forgotPassword(email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found for this email.");
      } else {
        throw Exception(e.message ?? "An error occurred while sending the password reset email.");
      }
    }
  }

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    // TODO: implement signIn
    try {
      await remoteAuthSource.signIn(email, password);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found with this email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Incorrect password.");
      } else {
        throw Exception(e.message ?? "Login failed.");
      }
    }
  }
}
