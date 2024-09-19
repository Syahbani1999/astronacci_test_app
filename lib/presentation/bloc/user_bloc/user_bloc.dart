import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:astronacci_test_app/domain/usecases/create_user.dart';
import 'package:astronacci_test_app/domain/usecases/delete_user.dart';
import 'package:astronacci_test_app/domain/usecases/get_users.dart';
import 'package:astronacci_test_app/domain/usecases/search_user.dart';
import 'package:astronacci_test_app/domain/usecases/update_user.dart';
import 'package:astronacci_test_app/domain/usecases/update_user_data.dart';
import 'package:astronacci_test_app/tools.dart';
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
  final UpdateUserDataCase updateUserDataCase;
  UserBloc({
    required this.deleteUserCase,
    required this.getUsersCase,
    required this.updateUserCase,
    required this.createUserCase,
    required this.searchUsersCase,
    required this.updateUserDataCase,
  }) : super(UserInitial()) {
    // update user data
    on<UserLoadEvent>((event, emit) async {
      try {
        emit(UserLoading());
        final result = await updateUserDataCase.call(event.idUser);
        result.fold(
          (failure) => emit(UserError(failure.message)),
          (data) {
            emit(UserDataUpdated(data));
            printConsole(UserModel.fromEntity(data).toJson());
          },
        );
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    // load list user
    on<UsersLoadEvent>((event, emit) async {
      try {
        final result = await getUsersCase.call(event.page, event.pageSize);
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
          add(UsersLoadEvent(page: 1, pageSize: 5));
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
          add(UsersLoadEvent(page: 1, pageSize: 5));
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
          add(UsersLoadEvent(page: 1, pageSize: 5));
        });
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
