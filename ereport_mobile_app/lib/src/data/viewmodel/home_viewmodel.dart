import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeViewModel extends ChangeNotifier {

  ResultState _state = ResultState.loading;

  ResultState get state => _state;


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