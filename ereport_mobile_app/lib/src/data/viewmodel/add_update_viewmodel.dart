import 'dart:convert';

import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:ereport_mobile_app/src/data/data_source/remote/api_service.dart';
import 'package:ereport_mobile_app/src/data/models/get_burned_calorie_response.dart';
import 'package:ereport_mobile_app/src/data/models/get_meal_calorie_response.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

import '../../core/constants/screen_type.dart';
import '../auth/auth.dart';
import '../models/list_log_model.dart';

const List<String> listMeal = <String>['Breakfast','Lunch','Dinner','Snacks','Drinks Only'];
const List<String> listExercise = <String>['Cardiovascular','Strength','Workout Routines','Other'];


class AddUpdateViewModel extends ChangeNotifier {

  final ApiService apiService;
  final Firestore firestore;
  late Auth auth;

  String? _instanceName;
  double? _calorie;
  String? _searchQuery;
  String? _searchQuery2;
  String? _instanceType;
  String? _logType;
  bool? _isValidChoice;
  CheckMealCalorieResponse? _response;
  List<BurnedCalorieResponse>? _response2;
  late List<String> _list;
  late int _index;

  ResultState _state = ResultState.started;
  String? get instanceName => _instanceName;
  double? get calorie => _calorie;
  ResultState get state => _state;
  CheckMealCalorieResponse? get response => _response;
  bool? get isValidChoice => _isValidChoice;
  List<String> get list => _list;
  int get index => _index;
  List<BurnedCalorieResponse>? get response2 => _response2;

  AddUpdateViewModel({required this.auth,required this.firestore,required this.apiService}){
    _list = ['Choose an item'];
    _index = 0;
  }

  String? get searchQuery => _searchQuery;
  String? get searchQuery2 => _searchQuery2;

  void checkChoice() {
    if(_instanceType == null || _instanceType == 'Choose an item') {
      _isValidChoice = false;
    } else {
      _isValidChoice = true;
    }
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
    if (type == ScreenType.Meal.name) {
      _list.addAll(listMeal);
    } else {
      _list.addAll(listExercise);
    }
    notifyListeners();
  }

  void setInformation(int? index) {
    if (_logType == ScreenType.Meal.name) {
      if(_response!.items.isNotEmpty){
        _calorie = 0;
        _response!.items.forEach((element) {
          _calorie = _calorie! + element.calories;
        });
      }
      _instanceName = _searchQuery;
    }
    else {
      _instanceName = _response2![index!].name;
      _calorie = _response2![index].totalCalories.toDouble();
    }
    notifyListeners();
  }

  Future<bool> deleteLog(int index) async {
    _state = ResultState.loading;
    notifyListeners();
    final isMeal = (_logType == ScreenType.Meal.name) ? true : false;
    final uid = await auth.getCurrentUID();
    final result = await firestore.deleteLog(uid!, index, isMeal);
    if(result) {
      await Future.delayed(const Duration(milliseconds: 1000));
      _state = ResultState.hasData;
      notifyListeners();
      return true;
    }
    else {
      _state = ResultState.error;
      notifyListeners();
      return false;
    }


  }

  void setDataForUpdate(LogModel data){
    _instanceName = data.instanceName;
    _instanceType = data.instanceType;
    _calorie = data.calories;
    _logType = data.type;
    _index = _list.indexWhere((item) => item.contains('$_instanceType'));
    notifyListeners();
  }

  Future<bool> updateLog(int no) async {
    _state = ResultState.loading;
    notifyListeners();
    final isMeal = (_logType == ScreenType.Meal.name) ? true : false;
    final uid = await auth.getCurrentUID();
    final result = await firestore.updateLog(uid!, no, {
      'log_instance_name': _instanceName,
      'calories': _calorie
    },isMeal);
    if(result) {
      await Future.delayed(const Duration(milliseconds: 1000));
      _state = ResultState.hasData;
      notifyListeners();
      return true;
    }
    else {
      debugPrint(TextStrings.errorRuntime('updateLog', 'add_update_viewmodel.dart',null));
      _state = ResultState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> addLog() async {
    final bool isMeal = (_logType == ScreenType.Meal.name) ? true : false;
    _state = ResultState.loading;
    notifyListeners();
    final uid = await auth.getCurrentUID();
    final result = await firestore.addLog(isMeal,uid!,{'type': _logType,'log_instance_name': _instanceName,'calories':_calorie,'log_instance_type':_instanceType});
    if (result) _state = ResultState.addDataSuccess;
    notifyListeners();
    if (_state == ResultState.addDataSuccess) {
      _state = ResultState.loading;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1000));
      _state = ResultState.hasData;
      notifyListeners();
      return true;
    }
    else {
      debugPrint(TextStrings.errorRuntime('addLog', 'add_update_viewmodel.dart',null));
      _state = ResultState.error;
      notifyListeners();
      return false;
    }
  }

  void disposeViewModel() {
    _state = ResultState.started;
    _instanceName = null;
    _instanceType = null;
    _calorie = null;
    _searchQuery = null;
    _response = null;
    _response2 = null;
    _isValidChoice = null;
    _index = 0;
    _list.removeRange(1,_list.length);
  }

  Future<void> getMealCalorie() async {
    _state = ResultState.loading;
    notifyListeners();
    try{
      final response = await apiService.checkMealCalorie(_searchQuery!);
      final parsedJson = CheckMealCalorieResponse.fromJson(jsonDecode(response));
      _response = parsedJson;
      _state = ResultState.hasData;
    }
    catch(e){
      debugPrint(TextStrings.errorRuntime('getMealCalorie', 'add_update_viewmodel.dart',e.toString()));
      _state = ResultState.error;
    }
    notifyListeners();
  }

  Future<void> getActivityCalorie() async {
    _state = ResultState.loading;
    notifyListeners();
    late final int duration;
    if (_searchQuery2 == null) {
      duration = 0;
    } else {
      duration = int.parse(_searchQuery2!);
    }
    try{
      final response = await apiService.checkBurnedCalorie(_searchQuery!,duration);
      final parsedJson = burnedCalorieResponseFromJson(response);
      _response2 = parsedJson;
      _state = ResultState.hasData;
    }
    catch(e){
      debugPrint(TextStrings.errorRuntime('getActivityCalorie', 'add_update_viewmodel.dart',e.toString()));
      _state = ResultState.error;
    }
    notifyListeners();
  }


}