import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

    Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print(credential.toString());

      // Once signed in, return the UserCredential
      return await _firebaseAuth.signInWithCredential(credential);
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