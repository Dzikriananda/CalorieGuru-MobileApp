import 'dart:convert';

import 'package:ereport_mobile_app/src/data/auth/firestore.dart';
import 'package:ereport_mobile_app/src/data/data_source/remote/api_service.dart';
import 'package:ereport_mobile_app/src/data/models/get_meal_calorie_response.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

import '../auth/auth.dart';

const List<String> list = <String>['Breakfast','Lunch','Dinner','Snacks','Drinks Only'];


class AddUpdateViewModel extends ChangeNotifier {

  final ApiService apiService = ApiService();
  final Firestore firestore = Firestore();
  final Auth auth = Auth();

  String? _mealName;
  double? _calorie;
  String? _searchMealQuery;
  String? _mealType = list.first;
  String? _exerciseName;
  String? _logType;
  CheckMealCalorieResponse? _response;

  ResultState _state = ResultState.started;
  String? get mealName => _mealName;
  double? get calorie => _calorie;
  ResultState get state => _state;
  CheckMealCalorieResponse? get response => _response;


  AddUpdateViewModel();

  String? get searchMealQuery => _searchMealQuery;

  set setDropDown(String option){
    _mealType = option;
  }


  set setMealName(String mealName){
    _mealName = mealName;
    notifyListeners();
  }

  set setQueryMealName(String mealName){
    _searchMealQuery = mealName;
  }

  set setCalorie(String calorie){
    _calorie = double.parse(calorie);
    notifyListeners();
  }

  void setInformation(){
    if(_response!.items.length != 0){
      _calorie = 0;
      _response!.items.forEach((element) {
        _calorie = _calorie! + element.calories;
      });
    }
    _mealName = _searchMealQuery;
    notifyListeners();
  }

  Future<bool> addLog() async {
    _state = ResultState.loading;
    notifyListeners();
    final uid = await auth.getCurrentUID();
    firestore.addLog(uid!,{'type':'Meal','log_instance_name': _mealName,'calories':_calorie,'log_instance_type':_mealType});
    _state = ResultState.addDataSuccess;
    notifyListeners();
    if(_state == ResultState.addDataSuccess){
      _state = ResultState.loading;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1000));
      _state = ResultState.hasData;
      return true;
    }
    else return false;

  }

  void disposeViewModel(){
    _state = ResultState.started;
    _mealName = null;
    _calorie = null;
    _searchMealQuery = null;
    _response = null;
  }

  Future<void> getMealCalorie() async {
    _state = ResultState.loading;
    notifyListeners();
    try{
      final response = await apiService.checkMealCalorie(_searchMealQuery!);
      print(response);
      final parsedJson = CheckMealCalorieResponse.fromJson(jsonDecode(response));
      _response = parsedJson;
      _state = ResultState.hasData;
    }
    catch(e){
      print(e);
      _state = ResultState.error;
    }
    notifyListeners();
  }


}