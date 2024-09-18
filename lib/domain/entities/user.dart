import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.email,
    this.id,
    this.image,
    this.name,
    this.password,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? image;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        image,
      ];
}
