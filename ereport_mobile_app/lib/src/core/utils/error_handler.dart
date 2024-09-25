
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ErrorHandler {
  String handleLoginError(dynamic e) {
    String? errorMessage;
    if(e is FirebaseAuthException) {
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if(e.code == 'INVALID_LOGIN_CREDENTIALS') {
        errorMessage = 'Wrong Email/Password provided';
      } else {
        errorMessage = e.message;
      }
    } else if (e is PlatformException) {
      if(e.code.contains('network_error')) {
        errorMessage = 'Network Error';
      } else {
        errorMessage = e.code;
      }
    }
    return errorMessage ?? 'Try Again';
  }

}