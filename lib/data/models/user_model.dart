import 'package:astronacci_test_app/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends User {
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

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'image': image,
    };
  }

  User toEntity() => User(
        email: email,
        id: id,
        image: image,
        name: name,
        password: password,
      );

  static UserModel fromEntity(User user) {
    return UserModel(
      email: user.email,
      id: user.id,
      image: user.image,
      name: user.name,
      password: user.password,
    );
  }
}
