import 'dart:io';

import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:astronacci_test_app/tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class RemoteAuthSource {
  Future<List<UserModel>> getUsers();
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String id);
  Future<void> signUp(UserModel user);
  Future<void> forgotPassword(String email);
  Future<UserModel> signIn(String email, String password);
  Future<void> createUser(UserModel user);
}

class RemoteAuthSourceImpl implements RemoteAuthSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  RemoteAuthSourceImpl({required this.firestore, required this.firebaseAuth, required this.firebaseStorage});

  @override
  Future<List<UserModel>> getUsers() async {
    final snapshot = await firestore.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).update(user.toJson());
  }

  @override
  Future<void> createUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  @override
  Future<void> deleteUser(String id) async {
    await firestore.collection('users').doc(id).delete();
  }

  @override
  Future<void> signUp(UserModel userModel) async {
    String? imageUrl;
    if (userModel.image != null) {
      final storageRef = firebaseStorage.ref().child('user_images/${userModel.email}.jpg');
      await storageRef.putFile(File(userModel.image!));
      imageUrl = await storageRef.getDownloadURL();
    }
    final result =
        await firebaseAuth.createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!);
    final user = result.user;
    if (user != null) {
      final userData = userModel.toJson();
      userData['image'] = imageUrl;
      userData['id'] = user.uid;
      await createUser(UserModel.fromJson(userData));
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    // Send password reset email
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    DocumentSnapshot userData = await firestore.collection('users').doc(result.user!.uid).get();

    return UserModel.fromFirestore(userData);
  }
}
