import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/models/list_log_model.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends ChangeNotifier {

  late ResultState _state;

  ResultState get state => _state;
  late String _todayDate;
  late Auth auth;
  late Firestore firestore;
  double? _consumedCalories;
  double? _burnedCalories;
  double? _caloriesLeft;
  late List<LogModel> _listLog;
  UserModel? _user;

  UserModel? get getUser => _user;
  String get todayDate => _todayDate;
  double? get consumedCalories => _consumedCalories;
  double? get burnedCalories => _burnedCalories;
  double? get caloriesLeft => _caloriesLeft;
  List<LogModel> get listLog => _listLog;

  String? get name => _user?.name;
  double? get calorieNeed => _user?.calorieNeed;


  String getData(String? input) {
    if (input == null) {
      return TextStrings.loadingText;
    } else {
      return input;
    }
  }


  HomeViewModel({required this.auth,required this.firestore}){
    _listLog = [];
    getTodayDate();
    _state = ResultState.loading;
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
    _caloriesLeft = thisUser?.calorieNeed;
    notifyListeners();
  }


}