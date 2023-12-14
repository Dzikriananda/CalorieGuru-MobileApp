
import 'dart:convert';
import 'dart:io';
import 'package:ereport_mobile_app/src/core/constants/activity_level.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:ereport_mobile_app/src/data/models/get_calorie_response.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/data/data_source/remote/api_service.dart';

class RegisterViewModel extends ChangeNotifier{

  ApiService apiService = ApiService();

  ResultState _state = ResultState.started;

  ResultState get state => _state;

  late UserModel _userData;

  int _page = 0;

  late bool _visible1;
  late bool _visible2;
  late bool _visible3;
  String? _sex;
  int? _age;
  int? _buttonChoosedIndex;
  late String _result;
  GetCalorieResponse? _response;
  String? _errorMessage;


  int get page => _page;
  bool? get gender => _userData.gender;
  String? get birthdate => _userData.birthdate;
  String? get name => _userData.name;
  String? get activityLevel => _userData.activityLevel;
  String get result => _result;
  double? get height => _userData.height;
  double? get weight => _userData.weight;
  GetCalorieResponse? get response => _response;
  String? get errorMessage => _errorMessage;
  bool _hasUpdated = false;
  bool get visible1 => _visible1;
  bool get visible2 => _visible2;
  bool get visible3 => _visible3;

  int? get choosedIndex => _buttonChoosedIndex;
  bool get hasUpdate => _hasUpdated;

  RegisterViewModel(){
    _userData = UserModel.createFirstTime();
    _visible1 = false;
    _visible2 = false;
    _visible3 = false;

  }

  void checkVisibility_firstPage(){
    if(_userData.gender == null) {
      _visible1 = true;
    } else {
      _visible1 = false;
    }
    if(_userData.birthdate == null) {
      _visible2 = true;
    } else {
      _visible2 = false;
    }
    notifyListeners();
  }

  void checkVisibility_secondPage(){
    if(_userData.activityLevel == null) {
      _visible3 = true;
    } else {
      _visible3 = false;
    }
    notifyListeners();
  }



  void getCalorieNeed() async {
    Map<String,dynamic> queryParams = {
      'age' : '$_age',
      'gender' : _sex,
      'weight' : '${_userData.weight}',
      'height' : '${_userData.height}',
      'activitylevel' : '${_userData.activityLevel}',

    };
    _state = ResultState.loading;
    notifyListeners();
    try{
      final thisResponse = await apiService.checkCalorie(queryParams = queryParams);
      _response = GetCalorieResponse.fromJson(jsonDecode(thisResponse));
      final calorieNeed = _response?.data.goals.maintainWeight.toStringAsFixed(1);
      _userData.calorieNeed = double.parse(calorieNeed!);
      _state = ResultState.hasData;
      notifyListeners();
    }
    on SocketException{
      _errorMessage = TextStrings.errorAlert_1;
      _state = ResultState.error;
      notifyListeners();
    }
    catch(e){
      _errorMessage = e.toString();
      _state = ResultState.error;
      notifyListeners();
    }
  }

  set activityLevel(String? activityLevel){
    _userData.activityLevel = activityLevel;
    notifyListeners();
  }

  set name(String? name){
    _userData.name = name;
    notifyListeners();
  }

  set height(double? height){
    _userData.height = height;
    notifyListeners();
  }


  set weight(double? weight){
    _userData.weight = weight;
    notifyListeners();
  }

  set birthdate(String? birthdate){
    _userData.birthdate = birthdate;
    _age = calculateAge(birthdate!);
    print(_age);
    notifyListeners();
  }

  void pressedButton(int index){
    if(index == _buttonChoosedIndex){
      _buttonChoosedIndex = null;
      setActivityLevel(-1);
    }
    else {
      _buttonChoosedIndex = index;
      setActivityLevel(index);
    }
    notifyListeners();
  }

  void setActivityLevel(int index){
    switch(index){
      case -1: {_userData.activityLevel = null;} break;
      case 0: {_userData.activityLevel = ActivityLevel.level_1.name;} break;
      case 1: {_userData.activityLevel = ActivityLevel.level_2.name;} break;
      case 2: {_userData.activityLevel = ActivityLevel.level_3.name;} break;
      case 3: {_userData.activityLevel = ActivityLevel.level_4.name;} break;
      case 4: {_userData.activityLevel = ActivityLevel.level_5.name;} break;
      case 5: {_userData.activityLevel = ActivityLevel.level_6.name;} break;


    }
  }



  void nextPage(){
    if(_page <= 2){
      _page++;
      notifyListeners();
    }
  }

  void setGender(bool? gender){
    _userData.gender = gender;
    if(gender != null) {
      if(_userData.gender!) _sex = "female";
      else _sex = "male";
    }
    notifyListeners();
  }

  void previousPage(){
    if(_page >= 0){
      _page--;
      notifyListeners();
    }
  }


  Future<void> updateData() async {
    _state = ResultState.loading;
    notifyListeners();
    try {
      final uid = await Auth().getCurrentUID();
      _userData.hasFilledData = true;
      final result = await Firestore().updateUser(uid!, _userData);
      if(result){
        _state = ResultState.addDataSuccess;
        notifyListeners();
      }
      else{
        _state = ResultState.error;
        _userData.hasFilledData = false;
        notifyListeners();
      }
    } catch(e){
      debugPrint(TextStrings.errorRuntime('UpdateData()', 'register_viewmodel.dart',e.toString()));
      _state = ResultState.error;
      notifyListeners();
    }
  }

  void disposeViewModel(){
      _state = ResultState.started;
      _userData = UserModel.createFirstTime();
  }






}