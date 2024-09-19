import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  const UserModel({super.id, super.name, super.email, super.password, super.image});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      password: doc['password'],
      image: doc['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'image': image,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
    );
  }

  UserEntity toEntity() => UserEntity(
        email: email,
        id: id,
        image: image,
        name: name,
        password: password,
      );

  static UserModel fromEntity(UserEntity user) {
    return UserModel(
      email: user.email,
      id: user.id,
      image: user.image,
      name: user.name,
      password: user.password,
    );
  }
}
