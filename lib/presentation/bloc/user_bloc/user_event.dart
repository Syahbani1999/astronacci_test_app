part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UsersLoadEvent extends UserEvent {
  final int page;
  final int pageSize;
  const UsersLoadEvent({required this.page, required this.pageSize});
}

class UserLoadEvent extends UserEvent {
  final String idUser;

  const UserLoadEvent(this.idUser);

  @override
  List<Object?> get props => [idUser];
}

class UserAddEvent extends UserEvent {
  final UserEntity user;
  const UserAddEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UserUpdateEvent extends UserEvent {
  final UserEntity user;
  const UserUpdateEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UserDeleteEvent extends UserEvent {
  final String userId;
  const UserDeleteEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SearchUsersEvent extends UserEvent {
  final String query;

  const SearchUsersEvent(this.query);
}
