part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

final class UserInitial extends UserState {}

final class UserEmpty extends UserState {}

final class UserLoading extends UserState {}

final class UserAdded extends UserState {}

final class UserUpdated extends UserState {}

final class UserDeleted extends UserState {}

final class UserError extends UserState {
  final String message;
  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

final class UserLoaded extends UserState {
  final List<UserEntity> result;
  const UserLoaded(this.result);

  @override
  List<Object?> get props => [result];
}
