import 'package:astronacci_test_app/domain/entities/user.dart';

import '../repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<void> call(User user) async {
    await repository.updateUser(user);
  }
}
