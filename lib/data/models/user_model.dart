import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  const UserModel({super.id, super.name, super.email, super.image});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      image: doc['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }

  UserEntity toEntity() => UserEntity(
        email: email,
        id: id,
        image: image,
        name: name,
      );

  static UserModel fromEntity(UserEntity user) {
    return UserModel(
      email: user.email,
      id: user.id,
      image: user.image,
      name: user.name,
    );
  }
}
