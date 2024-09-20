
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

  late ApiService apiService;
  late ResultState _state;
  late UserModel _userData;
  late int _page;
  late bool _visible1;
  late bool _visible2;
  late bool _visible3;
  late Auth auth;
  late Firestore firestore;
  String? _sex;
  int? _age;
  int? _buttonChoosedIndex;
  late String _result;
  GetCalorieResponse? _response;
  String? _errorMessage;
  int? activityUserLevel;


  int get page => _page;
  ResultState get state => _state;
  bool? get gender => _userData.gender;
  String? get birthdate => _userData.birthdate;
  String? get name => _userData.name;
  String? get activityLevel => _userData.activityLevel;
  String get result => _result;
  double? get height => _userData.height;
  double? get weight => _userData.weight;
  GetCalorieResponse? get response => _response;
  String? get errorMessage => _errorMessage;
  UserModel get userData => _userData;
  late bool _hasUpdated;
  bool get visible1 => _visible1;
  bool get visible2 => _visible2;
  bool get visible3 => _visible3;

  int? get choosedIndex => _buttonChoosedIndex;
  bool get hasUpdate => _hasUpdated;

  RegisterViewModel({required this.apiService,required this.firestore,required this.auth}){
    _state = ResultState.started;
    _hasUpdated = false;
    _page = 0;
    _userData = UserModel.createFirstTime();
    _visible1 = false;
    _visible2 = false;
    _visible3 = false;

  }

  void checkVisibilityFirstPage(){
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

  void checkVisibilitySecondPage(){
    if(_userData.activityLevel == null) {
      _visible3 = true;
    } else {
      _visible3 = false;
    }
    notifyListeners();
  }



  void getCalorieNeed() async {
    Map<String,dynamic> queryParams = {
      'age' : _age,
      'gender' : _sex,
      'weight' : _userData.weight,
      'height' : _userData.height,
      'activitylevel' : activityUserLevel,

    };
    _state = ResultState.loading;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    final calorieNeed = calculateTDEE(queryParams).toStringAsFixed(1);
    _userData.calorieNeed = double.parse(calorieNeed);
    _state = ResultState.hasData;
    notifyListeners();
    // try{
    //   print('mencari data');
    //   final thisResponse = await apiService.checkCalorie(queryParams = queryParams);
    //   print('ada data');
    //   print('data : $thisResponse');
    //   _response = GetCalorieResponse.fromJson(jsonDecode(thisResponse));
    //   print(_response);
    //   final calorieNeed = _response?.data.goals.maintainWeight.toStringAsFixed(1);
    //   _userData.calorieNeed = double.parse(calorieNeed!);
    //   _state = ResultState.hasData;
    //   notifyListeners();
    // }
    // on SocketException{
    //   _errorMessage = TextStrings.errorAlert_1;
    //   _state = ResultState.error;
    //   notifyListeners();
    // }
    // catch(e){
    //   _errorMessage = e.toString();
    //   _state = ResultState.error;
    //   notifyListeners();
    // }
  }

  double calculateTDEE(Map<String,dynamic> map) {
    late double bmr;
    late double amr;
    switch(map['activitylevel']){
      case 0: {amr = 1.2;} break;
      case 1: {amr = 1.375;} break;
      case 2: {amr = 1.55;} break;
      case 3: {amr = 1.725;} break;
      case 4: {amr = 1.9;} break;
      case 5: {amr = 2;} break;
    }
    if(map['gender'] == 'male') {
      bmr = 66 + (13.7 * map['weight']) + (5 * map['height']) - (6.8 * map['age']);
    } else {
      bmr = 66 + (9.6 * map['weight']) + (1.8 * map['height']) - (4.7 * map['age']);
    }
    return bmr * amr;
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
    activityUserLevel = index;
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

  // void setActivityLevel(int index){
  //   switch(index){
  //     case -1: {_userData.activityLevel = null;} break;
  //     case 0: {_userData.activityLevel = ActivityLevel.level_1.name;} break;
  //     case 1: {_userData.activityLevel = ActivityLevel.level_2.name;} break;
  //     case 2: {_userData.activityLevel = ActivityLevel.level_3.name;} break;
  //     case 3: {_userData.activityLevel = ActivityLevel.level_4.name;} break;
  //     case 4: {_userData.activityLevel = ActivityLevel.level_5.name;} break;
  //     case 5: {_userData.activityLevel = ActivityLevel.level_6.name;} break;
  //
  //
  //   }
  // }



  void nextPage(){
    if(_page <= 2){
      _page++;
      notifyListeners();
    }
  }

  void setGender(bool? gender){
    _userData.gender = gender;
    if(gender != null) {
      if(_userData.gender!) {
        _sex = "female";
      } else {
        _sex = "male";
      }
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
      final uid = await auth.getCurrentUID();
      _userData.hasFilledData = true;
      final result = await firestore.updateUser(uid!, _userData);
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