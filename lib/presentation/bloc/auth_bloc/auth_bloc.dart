import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/domain/usecases/signin_user.dart';
import 'package:astronacci_test_app/domain/usecases/forgot_password.dart';
import 'package:astronacci_test_app/domain/usecases/signup_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/local_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpCase signUpCase;
  final ForgotPasswordCase forgotPassword;
  final SignInCase signIn;
  final localServices = LocalServices();
  AuthBloc({required this.signUpCase, required this.forgotPassword, required this.signIn}) : super(AuthInitial()) {
    // register
    on<AuthCheckStatus>((event, emit) async {
      try {
        await Future.delayed(const Duration(seconds: 2));
        emit(AuthLoading());
        final responseLoginUser = await localServices.getResponseUserModel();
        final token = await localServices.getToken();
        if (token != null) {
          if (responseLoginUser != null) {
            emit(AuthSuccess(responseLoginUser.toEntity()));
          }
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
        rethrow;
      }
    });

    on<SignUpEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final result = await signUpCase.call(event.user);

        result.fold((failure) => emit(AuthFailure(failure.message)), (data) => emit(AuthSuccessRegister()));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // sign in
    on<SignInEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final result = await signIn.call(event.email, event.password);

        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (data) {
            localServices.saveToken(data.id ?? '');
            localServices.saveUserResponseModel(UserModel.fromEntity(data));
            emit(AuthSuccess(data));
          },
        );
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    //forgot password
    on<ForgotPasswordEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        final result = await forgotPassword.call(event.email);

        result.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (data) => emit(PasswordResetSentEmailSuccess()),
        );
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
