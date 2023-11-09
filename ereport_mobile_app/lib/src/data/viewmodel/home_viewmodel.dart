import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/models/list_log_model.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:ereport_mobile_app/src/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends ChangeNotifier {

  ResultState _state = ResultState.loading;

  ResultState get state => _state;
  late String _todayDate;
  final Auth auth = Auth();
  final Firestore firestore = Firestore();
  double? _consumedCalories;
  double? _burnedCaloried;
  double? _caloriesLeft;
  List<ListLogModel> _listLog = [];
  UserModel? _user;

  UserModel? get getUser => _user;
  String get todayDate => _todayDate;
  double? get consumedCalories => _consumedCalories;
  double? get caloriesLeft => _caloriesLeft;
  List<ListLogModel> get listLog => _listLog;



  HomeViewModel(){
    getTodayDate();
  }

  void getTodayDate(){
    final result = DateFormat('MMMMEEEEd').format(DateTime.now());
    _todayDate = result;
  }

  Future<void> getTodayCalorie() async {
    String? uid = await auth.getCurrentUID();
    final result = await firestore.getTodayCalorie(uid!);
    print('hasil adalah $result');
    if(result != null){
      _consumedCalories = result['consumedCalories'];
      _caloriesLeft = result['calorieBudget'] - result['consumedCalories'];
      notifyListeners();
    }
    else{
      _consumedCalories = 0;
    }
    notifyListeners();
  }

  Future<void> getListLog() async {
    String? uid = await auth.getCurrentUID();
    _listLog = await firestore.getListLog(uid!);
    notifyListeners();
  }

  void refreshData(){
    getTodayCalorie();
    getListLog();
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

  Future<void> getUserData() async {
    final UID = await auth.getCurrentUID();
    final UserModel? thisUser = await firestore.getUserData(UID!);
    _user = thisUser;
    if(_caloriesLeft == null){
      _caloriesLeft = thisUser?.calorieNeed;
    }
    notifyListeners();
  }

  void testFungsi() {
    print("menjalankan getUserDATA");
  }

}