part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  const SignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final UserEntity user;
  const SignUpEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  const ForgotPasswordEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthCheckStatus extends AuthEvent {}
