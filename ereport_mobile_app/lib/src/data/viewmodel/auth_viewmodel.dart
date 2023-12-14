import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthViewModel extends ChangeNotifier {

  ResultState _state = ResultState.started;
  late Firestore firestore;
  late Auth auth;


  ResultState get state => _state;

  String? _email;
  String? _pwd;
  String? _pwd2;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  String? get password => _pwd;
  String? get password_2 => _pwd2;

  AuthViewModel({required this.firestore,required this.auth});

  set setViewModelState(ResultState state){
    _state = state;
  }

  set setEmail(String email){
    _email = email;
  }

  set setPwd(String pwd){
    _pwd = pwd;
  }

  set setPwd2(String pwd){
    _pwd2 = pwd;
  }


  void disposeViewModel(){
    _state = ResultState.started;
  }


  Future<void> signIn() async{
    final streamer = auth.authStateChanges.listen((event) async {
      if(event == null) debugPrint('unLogged');
      else {
        try{
          final hasData = await firestore.hasFilledData(event.uid);
          if(hasData != null){
            if(hasData){
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
        on FirebaseAuthException catch(e){
          debugPrint(TextStrings.errorRuntime('SignIn', 'auth_viewmodel.dart',e.toString()));
        }
      }
    });
    try{
      _state = ResultState.loading;
      notifyListeners();
      await auth.signInWithEmailAndPassword(email: _email!, password: _pwd!);
    }
    on FirebaseAuthException catch(e){
      _errorMessage = e.toString();
      _state = ResultState.error;
      notifyListeners();
    }
    streamer.cancel();
  }

  Future<void> signUp() async{
    _state = ResultState.loading;
    notifyListeners();
    final streamer = auth.authStateChanges.listen((event) async {
      if(event == null) debugPrint("gagal register");
      else {
        try{
          await firestore.addUser(event.uid);
          _state = ResultState.loggedNotFilledData;
          notifyListeners();
        }
        on FirebaseAuthException catch(e){
          debugPrint(e.toString());
        }
      }
    });

    try{
      _state = ResultState.loading;
      notifyListeners();
      await auth.createUserWithEmailAndPassword(email: _email!, password: _pwd!);

    }
    on FirebaseAuthException catch(e){
      debugPrint(TextStrings.errorRuntime('SignUp', 'auth_viewmodel.dart',e.toString()));
      _errorMessage = e.toString();
      _state = ResultState.error;
      notifyListeners();
    }
    streamer.cancel();
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