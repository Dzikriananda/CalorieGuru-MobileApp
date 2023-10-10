import 'dart:async';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

class SplashScreenViewModel extends ChangeNotifier {

  final auth = Auth();
  late StreamSubscription<User?> _sub;
  late bool isLogged;



  ResultState _state = ResultState.loading;

  ResultState get state => _state;

  SplashScreenViewModel(){
      _sub = auth.authStateChanges.listen(
              (event) {
                if(event == null){
                  _state = ResultState.unLogged;
                  notifyListeners();
                }
                else if(event != null){
                  _state = ResultState.logged;
                  notifyListeners();
                }
                else{
                  _state = ResultState.error;
                }
              }
      );
  }

  void dispose(){
    _sub.cancel();
  }

}