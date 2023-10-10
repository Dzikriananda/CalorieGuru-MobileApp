import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginViewModel extends ChangeNotifier {

  ResultState _state = ResultState.loading;

  ResultState get state => _state;

  String? _email;
  String? _pwd;

  set setEmail(String email){
    _email = email;
  }

  set setPwd(String pwd){
    _pwd = pwd;
  }

  void dispose(){
    _state = ResultState.loading;
    // notifyListeners();
  }


  Future<void> signIn() async{
    try{
      _state = ResultState.loading;
      notifyListeners();
      await Auth().signInWithEmailAndPassword(email: _email!, password: _pwd!);
      print("sukses loggin");
      _state = ResultState.logged;
      notifyListeners();
    }
    on FirebaseAuthException catch(e){
      print("gagal login");
      print('error $e');
      _state = ResultState.error;
      notifyListeners();
    }
  }


  void checkNetwork() async {
    _state = ResultState.loading;
    notifyListeners();
    var status = await checkConnection();
    if(status){
      _state = ResultState.hasData;
      notifyListeners();
    }
    else{
      _state = ResultState.noConnection;
      notifyListeners();
    }

  }

}