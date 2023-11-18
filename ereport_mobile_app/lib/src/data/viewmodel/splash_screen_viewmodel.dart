import 'dart:async';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

class SplashScreenViewModel extends ChangeNotifier {

  final auth = Auth();
  late StreamSubscription<User?> _sub;
  late bool isLogged;
  bool? hasFilledData;
  String? _errorMessage = 'No Connection';



  ResultState _state = ResultState.loading;

  ResultState get state => _state;
  String? get errorMessage => _errorMessage;

  SplashScreenViewModel(){
      _sub = auth.authStateChanges.listen(
              (event) async {
                if(event == null){
                  _state = ResultState.unLogged;
                  notifyListeners();
                }
                else if(event != null){
                  print('mengecek UID : ${event.uid}');
                  final hasFilledData = await Firestore().hasFilledData(event.uid);
                  if(hasFilledData != null){
                    print('hasfilleddata not null');
                    print(hasFilledData);
                    if(hasFilledData){
                      _state = ResultState.logged;
                    }
                    else{
                      _state = ResultState.loggedNotFilledData;
                    }
                  }
                  else{
                    print('hasfilled data null');
                    _state = ResultState.error;
                  }
                  notifyListeners();
                }
              }
      );
  }

  void retry(){
    
  }

  void dispose(){
    _sub.cancel();
  }

}