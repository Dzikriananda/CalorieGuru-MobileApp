import 'dart:convert';

import 'package:ereport_mobile_app/src/data/auth/firestore.dart';
import 'package:ereport_mobile_app/src/data/data_source/remote/api_service.dart';
import 'package:ereport_mobile_app/src/data/models/get_burned_calorie_response.dart';
import 'package:ereport_mobile_app/src/data/models/get_meal_calorie_response.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

import '../../core/constants/screen_type.dart';
import '../auth/auth.dart';

const List<String> listMeal = <String>['Breakfast','Lunch','Dinner','Snacks','Drinks Only'];
const List<String> listExercise = <String>['Cardiovascular','Strength','Workout Routines','Other'];


class AddUpdateViewModel extends ChangeNotifier {

  final ApiService apiService = ApiService();
  final Firestore firestore = Firestore();
  final Auth auth = Auth();

  String? _instanceName;
  double? _calorie;
  String? _searchQuery;
  String? _searchQuery2;
  String? _instanceType;
  String? _logType;
  bool? _isValidChoice;
  CheckMealCalorieResponse? _response;
  List<BurnedCalorieResponse>? _response2;
  List<String> _list=['Choose an item'];

  ResultState _state = ResultState.started;
  String? get instanceName => _instanceName;
  double? get calorie => _calorie;
  ResultState get state => _state;
  CheckMealCalorieResponse? get response => _response;
  bool? get isValidChoice => _isValidChoice;
  List<String> get list => _list;
  List<BurnedCalorieResponse>? get response2 => _response2;

  AddUpdateViewModel();

  String? get searchQuery => _searchQuery;
  String? get searchQuery2 => _searchQuery2;

  void checkChoice() {
    if(_instanceType == null || _instanceType == 'Choose an item') _isValidChoice = false;
    else _isValidChoice = true;
    notifyListeners();
  }

  set logType(String type){
    _logType = type;
  }

  set setDropDown(String option) {
    _instanceType = option;
  }

  set setQuery2(String query2) {
    _searchQuery2 = query2;
  }


  set setInstanceName(String instanceName) {
    _instanceName = instanceName;
    notifyListeners();
  }

  set setQuery(String instanceName) {
    _searchQuery = instanceName;
  }

  set setCalorie(String calorie) {
    final input = double.parse(calorie);
    _calorie = double.parse(input.toStringAsFixed(1));
    notifyListeners();
  }

  void setLogType(String type) {
    if (type == ScreenType.Meal.name) _list.addAll(listMeal);
    else _list.addAll(listExercise);
    notifyListeners();
  }

  void setInformation(int? index) {
    if (_logType == ScreenType.Meal.name) {
      if(_response!.items.length != 0){
        _calorie = 0;
        _response!.items.forEach((element) {
          _calorie = _calorie! + element.calories;
        });
      }
      _instanceName = _searchQuery;
    }
    else {
      _instanceName = _response2![index!].name;
      _calorie = _response2![index!].totalCalories.toDouble();
    }
    notifyListeners();
  }

  Future<bool> addLog() async {
    final bool isMeal = (_logType == ScreenType.Meal.name) ? true : false;
    _state = ResultState.loading;
    notifyListeners();
    final uid = await auth.getCurrentUID();
    firestore.addLog(isMeal,uid!,{'type': _logType,'log_instance_name': _instanceName,'calories':_calorie,'log_instance_type':_instanceType});
    _state = ResultState.addDataSuccess;
    notifyListeners();
    if (_state == ResultState.addDataSuccess) {
      _state = ResultState.loading;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1000));
      _state = ResultState.hasData;
      return true;
    }
    else return false;

  }

  void disposeViewModel() {
    _state = ResultState.started;
    _instanceName = null;
    _calorie = null;
    _searchQuery = null;
    _response = null;
    _response2 = null;
    _isValidChoice = null;
    _list.removeRange(1,_list.length);
  }

  Future<void> getMealCalorie() async {
    _state = ResultState.loading;
    notifyListeners();
    try{
      final response = await apiService.checkMealCalorie(_searchQuery!);
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

  Future<void> getActivityCalorie() async {
    _state = ResultState.loading;
    notifyListeners();
    late final int duration;
    if (_searchQuery2 == null) duration = 0;
    else duration = int.parse(_searchQuery2!);
    print(duration);
    try{
      final response = await apiService.checkBurnedCalorie(_searchQuery!,duration);
      final parsedJson = burnedCalorieResponseFromJson(response);
      _response2 = parsedJson;
      _state = ResultState.hasData;
    }
    catch(e){
      print(e);
      _state = ResultState.error;
    }
    notifyListeners();
  }


}