import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    User? get currentUser => _firebaseAuth.currentUser;

    Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

    Future<void> signInWithEmailAndPassword({
      required String email,
      required String password
    }) async {
        await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }

    Future<void> changePassword({
      required String newPassword
    }) async {
      await _firebaseAuth.currentUser?.updatePassword(newPassword);
    }

    Future<void> changeEmail({
      required String newEmail
    }) async {
      await _firebaseAuth.currentUser?.updateEmail(newEmail);
    }

    Future<void> verifyEmail({required String newEmail}) async {
      await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(newEmail);
    }


    Future<User?> authenticateSettings({
      required String email,
      required String password
    }) async {
      final userCredential = await currentUser!.reauthenticateWithCredential(EmailAuthProvider.credential(email: email, password: password));
      return userCredential.user;
    }

    Future<void> createUserWithEmailAndPassword({
      required String email,
      required String password
    })async{
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    }

    Future<void> signOut() async{
      await _firebaseAuth.signOut();
    }

    Future<void> deleteAccount() async{
      await _firebaseAuth.currentUser?.delete();
    }


    Future<String?> getCurrentUID() async {
      return await _firebaseAuth.currentUser?.uid;
    }

}