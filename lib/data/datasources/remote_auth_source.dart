import 'package:astronacci_test_app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteAuthSource {
  Future<List<UserModel>> getUsers();
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String id);
  Future<void> signUp(UserModel user);
  Future<void> forgotPassword(String email);
  Future<void> signIn(String email, String password);
}

class RemoteAuthSourceImpl implements RemoteAuthSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  RemoteAuthSourceImpl({required this.firestore, required this.firebaseAuth});

  @override
  Future<List<UserModel>> getUsers() async {
    final snapshot = await firestore.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).update(user.toFirestore());
  }

  @override
  Future<void> deleteUser(String id) async {
    await firestore.collection('users').doc(id).delete();
  }

  @override
  Future<void> signUp(UserModel userModel) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!, password: userModel.password!);
    final user = result.user;
    if (user != null) {
      final userData = userModel.toFirestore();
      await firestore.collection('users').doc(user.uid).set(userData);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    // Send password reset email
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}
