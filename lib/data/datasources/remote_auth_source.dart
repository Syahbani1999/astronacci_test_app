import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RemoteAuthSource {
  Future<List<UserModel>> getUsers();
  Future<void> createUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String id);
}

class RemoteAuthSourceImpl implements RemoteAuthSource {
  final FirebaseFirestore firestore;
  RemoteAuthSourceImpl({required this.firestore});

  @override
  Future<List<UserModel>> getUsers() async {
    final snapshot = await firestore.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }

  @override
  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').add(user.toFirestore());
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).update(user.toFirestore());
  }

  @override
  Future<void> deleteUser(String id) async {
    await firestore.collection('users').doc(id).delete();
  }
}
