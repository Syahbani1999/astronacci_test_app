import 'package:astronacci_test_app/data/datasources/remote_auth_source.dart';
import 'package:astronacci_test_app/data/repositories/user_repository_impl.dart';
import 'package:astronacci_test_app/domain/repositories/user_repository.dart';
import 'package:astronacci_test_app/domain/usecases/create_user.dart';
import 'package:astronacci_test_app/domain/usecases/delete_user.dart';
import 'package:astronacci_test_app/domain/usecases/forgot_password.dart';
import 'package:astronacci_test_app/domain/usecases/get_users.dart';
import 'package:astronacci_test_app/domain/usecases/search_user.dart';
import 'package:astronacci_test_app/domain/usecases/signin_user.dart';
import 'package:astronacci_test_app/domain/usecases/signout_user.dart';
import 'package:astronacci_test_app/domain/usecases/signup_user.dart';
import 'package:astronacci_test_app/domain/usecases/update_user.dart';
import 'package:astronacci_test_app/domain/usecases/update_user_data.dart';
import 'package:astronacci_test_app/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:astronacci_test_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => UserBloc(
        createUserCase: locator(),
        deleteUserCase: locator(),
        getUsersCase: locator(),
        updateUserCase: locator(),
        searchUsersCase: locator(),
        updateUserDataCase: locator(),
      ));
  locator.registerFactory(() => AuthBloc(
      signUpCase: locator(), forgotPassword: locator(), signIn: locator(), signOutCase: locator()));

  // usecase
  locator.registerLazySingleton(() => GetUsersCase(locator()));
  locator.registerLazySingleton(() => CreateUserCase(locator()));
  locator.registerLazySingleton(() => UpdateUserCase(locator()));
  locator.registerLazySingleton(() => DeleteUserCase(locator()));
  locator.registerLazySingleton(() => SignInCase(locator()));
  locator.registerLazySingleton(() => SignUpCase(locator()));
  locator.registerLazySingleton(() => ForgotPasswordCase(locator()));
  locator.registerLazySingleton(() => SearchUsers(locator()));
  locator.registerLazySingleton(() => SignOutCase(locator()));
  locator.registerLazySingleton(() => UpdateUserDataCase(locator()));

  //repo
  locator
      .registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteAuthSource: locator()));

  // data source
  locator.registerLazySingleton<RemoteAuthSource>(() => RemoteAuthSourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      firebaseStorage: FirebaseStorage.instance));
}
