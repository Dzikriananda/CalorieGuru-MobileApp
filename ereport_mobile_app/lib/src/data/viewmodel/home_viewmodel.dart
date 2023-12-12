import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/models/list_log_model.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:ereport_mobile_app/src/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends ChangeNotifier {

  ResultState _state = ResultState.loading;

  ResultState get state => _state;
  late String _todayDate;
  final Auth auth = Auth();
  final Firestore firestore = Firestore();
  double? _consumedCalories;
  double? _burnedCalories;
  double? _caloriesLeft;
  List<LogModel> _listLog = [];
  UserModel? _user;

  UserModel? get getUser => _user;
  String get todayDate => _todayDate;
  double? get consumedCalories => _consumedCalories;
  double? get burnedCalories => _burnedCalories;
  double? get caloriesLeft => _caloriesLeft;
  List<LogModel> get listLog => _listLog;



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
    if(result != null){
      _consumedCalories = double.parse(result['consumedCalories'].toString());
      _burnedCalories = double.parse(result['burnedCalories'].toString());
      _caloriesLeft = result['calorieBudget'] - _consumedCalories + _burnedCalories;
      notifyListeners();
    }
    notifyListeners();
  }

  void disposeViewModel() {
    _consumedCalories = null;
    _burnedCalories = null;
    _caloriesLeft = null;
  }

  Future<void> getListLog() async {
    String? uid = await auth.getCurrentUID();
    _listLog = await firestore.getListLog(uid!);
    debugPrint(_listLog.length.toString());
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
    // if(_caloriesLeft == null){
    //   _caloriesLeft = thisUser?.calorieNeed;
    // }
    _caloriesLeft = thisUser?.calorieNeed;
    notifyListeners();
  }

  void testFungsi() {
    print("menjalankan getUserDATA");
  }

}