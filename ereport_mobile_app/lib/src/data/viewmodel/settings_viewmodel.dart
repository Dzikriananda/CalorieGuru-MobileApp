import 'dart:async';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

class SettingsViewModel extends ChangeNotifier {

  final auth = Auth();
  late StreamSubscription<User?> _sub;

  ResultState _state = ResultState.loading;

  ResultState get state => _state;

  SettingsViewModel(){
    print("state di settingsviewmodel saat instantiate: $_state");
  }

  void init(){
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

  void dispose(){
    _state = ResultState.loading;
    notifyListeners();
  }

  Future<void> logOut() async {
    await auth.signOut();
  }



}