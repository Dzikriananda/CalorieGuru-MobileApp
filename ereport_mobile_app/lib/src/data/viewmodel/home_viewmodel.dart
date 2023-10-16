import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore.dart';

class HomeViewModel extends ChangeNotifier {

  ResultState _state = ResultState.loading;

  ResultState get state => _state;
  final Auth auth = Auth();
  final Firestore firestore = Firestore();
  LocalUser? _user;

  LocalUser? get getUser => _user;


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

  Future<void> getUserData() async {
    // print("menjalankan getUserDATA");
    final UID = await auth.getCurrentUID();
    final LocalUser? thisUser = await firestore.getUserData(UID!);
    _user = thisUser!;
    notifyListeners();
  }

  void testFungsi() {
    print("menjalankan getUserDATA");
  }

}