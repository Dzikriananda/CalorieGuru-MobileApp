import 'dart:async';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

class SplashScreenViewModel extends ChangeNotifier {

  late final Auth _auth;
  late StreamSubscription<User?> _sub;
  late bool isLogged;
  bool? hasFilledData;
  late ResultState _state;

  ResultState get state => _state;

  SplashScreenViewModel({required Auth auth}) : _auth = auth{
      _state = ResultState.loading;
      _sub = _auth.authStateChanges.listen(
              (event) async {
                if(event == null){
                  _state = ResultState.unLogged;
                  notifyListeners();
                }
                else if(event != null){
                  final hasFilledData = await Firestore().hasFilledData(event.uid);
                  if(hasFilledData != null){
                    if(hasFilledData){
                      _state = ResultState.logged;
                    }
                    else{
                      _state = ResultState.loggedNotFilledData;
                    }
                  }
                  else{
                    _state = ResultState.error;
                  }
                  notifyListeners();
                }
              }
      );
  }

  void disposeViewModel(){
    _sub.cancel();
  }

}