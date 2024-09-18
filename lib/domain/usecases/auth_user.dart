import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignIn {
  final UserRepository repository;

  SignIn(this.repository);

  Future<void> call(String username, String password) async {
    await repository.signIn(username, password);
  }
}
