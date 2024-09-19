import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/domain/usecases/create_user.dart';
import 'package:astronacci_test_app/domain/usecases/delete_user.dart';
import 'package:astronacci_test_app/domain/usecases/get_users.dart';
import 'package:astronacci_test_app/domain/usecases/search_user.dart';
import 'package:astronacci_test_app/domain/usecases/update_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersCase getUsersCase;
  final DeleteUserCase deleteUserCase;
  final UpdateUserCase updateUserCase;
  final CreateUserCase createUserCase;
  final SearchUsers searchUsersCase;
  UserBloc({
    required this.deleteUserCase,
    required this.getUsersCase,
    required this.updateUserCase,
    required this.createUserCase,
    required this.searchUsersCase,
  }) : super(UserInitial()) {
    // load list user
    on<UsersLoadEvent>((event, emit) async {
      try {
        final result = await getUsersCase.call();
        result.fold(
          (failure) => emit(UserError(failure.message)),
          (data) => emit(UserLoaded(data)),
        );
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    // search product
    on<SearchUsersEvent>((event, emit) async {
      try {
        emit(UserLoading());
        final result = await searchUsersCase.call(event.query);

        result.fold(
          (failure) => emit(UserError(failure.message)),
          (data) => emit(UserLoaded(data)),
        );
      } catch (e) {
        rethrow;
      }
    });

    // add user
    on<UserAddEvent>((event, emit) async {
      try {
        final result = await createUserCase.call(event.user);

        result.fold((failure) => emit(UserError(failure.message)), (_) {
          emit(UserAdded());
          add(UsersLoadEvent());
        });
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
    // update user
    on<UserUpdateEvent>((event, emit) async {
      try {
        final result = await updateUserCase.call(event.user);

        result.fold((failure) => emit(UserError(failure.message)), (_) {
          emit(UserUpdated());
          add(UsersLoadEvent());
        });
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
    // delete user
    on<UserDeleteEvent>((event, emit) async {
      try {
        final result = await deleteUserCase.call(event.userId);

        result.fold((failure) => emit(UserError(failure.message)), (_) {
          emit(UserDeleted());
          add(UsersLoadEvent());
        });
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
