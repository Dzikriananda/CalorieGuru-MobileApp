import 'dart:async';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

class SettingsViewModel extends ChangeNotifier {

  final auth = Auth();
  late StreamSubscription<User?> _sub;
  late UserModel _user;
  late final Firestore firestore;
  String? _email;

  ResultState _state = ResultState.loading;

  UserModel get user => _user;
  ResultState get state => _state;
  String? get email => _email;

  SettingsViewModel(){
    print('starting ini settingsviewmodel');
    _user = UserModel.createFirstTime();
    firestore = Firestore();
    // getUser();
  }

  void init(){
    getUser();
    _sub = auth
        .authStateChanges
        .listen((User? user) {
      if (user == null) {
        print('berhasil logout');
        _state = ResultState.unLogged;
        notifyListeners();

      } else {
        print('logout failed');
      }
    });
  }

  Future<void> getUser() async {
    final uid = await auth.getCurrentUID();
    final result = await firestore.getUserData(uid!);
    _user = result!;
    _email = auth.currentUser!.email!;
    print(_email);
    notifyListeners();
    print(user!.name);

  }

  void dispose(){
    _state = ResultState.loading;
    notifyListeners();
  }

  Future<void> logOut() async {
    await auth.signOut();
  }


}