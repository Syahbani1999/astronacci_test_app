import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.email,
    this.id,
    this.image,
    this.name,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? image;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        email,
        image,
      ];
}
