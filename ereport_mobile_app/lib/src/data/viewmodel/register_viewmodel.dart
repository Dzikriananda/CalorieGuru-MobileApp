
import 'dart:convert';

import 'package:ereport_mobile_app/src/core/constants/activity_level.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/models/get_calorie_response.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/data/data_source/remote/api_service.dart';

class RegisterViewModel extends ChangeNotifier{

  ApiService apiService = ApiService();

  ResultState _state = ResultState.started;

  ResultState get state => _state;

  int _page = 0;
  bool? _gender = null;
  late String _name;
  String? _birthdate;
  String? _sex;
  late double _weight;
  late double _height;
  int? _age;
  String? _activityLevel;
  int? _buttonChoosedIndex = null;
  late String _result;
  late GetCalorieResponse _response;


  int get page => _page;
  bool? get gender => _gender;
  String? get birthdate => _birthdate;
  String? get activityLevel => _activityLevel;
  String get result => _result;
  GetCalorieResponse get response => _response;

  int? get choosedIndex => _buttonChoosedIndex;

  void getCalorieNeed() async {
    Map<String,dynamic> queryParams = {
      'age' : '$_age',
      'gender' : '$_sex',
      'weight' : '$_weight',
      'height' : '$_height',
      'activitylevel' : '$_activityLevel',

    };
    _state = ResultState.loading;
    notifyListeners();
    try{
      final thisResponse = await apiService.checkCalorie(queryParams = queryParams);
      _response = GetCalorieResponse.fromJson(jsonDecode(thisResponse));
      _state = ResultState.hasData;
      notifyListeners();
    }
    catch(e){
      print("error $e");
      _state = ResultState.error;
      notifyListeners();
    }
  }

  void set activityLevel(String? activityLevel){
    _activityLevel = activityLevel;
    notifyListeners();
  }

  void set name(String name){
    _name = name;
    notifyListeners();
  }

  void set height(double height){
    _height = height;
    notifyListeners();
  }


  void set weight(double weight){
    _weight = weight;
    notifyListeners();
  }

  void set birthdate(String? birthdate){
    _birthdate = birthdate;
    _age = calculateAge(birthdate!);
    print(_age);
    notifyListeners();
  }

  void pressedButton(int index){
    if(index == _buttonChoosedIndex){
      _buttonChoosedIndex = null;
    }
    else {
      _buttonChoosedIndex = index;
      setActivityLevel(index);
    }
    notifyListeners();
  }

  void setActivityLevel(int index){
    switch(index){
      case 0: {_activityLevel = ActivityLevel.level_1.name;} break;
      case 1: {_activityLevel = ActivityLevel.level_2.name;} break;
      case 2: {_activityLevel = ActivityLevel.level_3.name;} break;
      case 3: {_activityLevel = ActivityLevel.level_4.name;} break;
      case 4: {_activityLevel = ActivityLevel.level_5.name;} break;
      case 5: {_activityLevel = ActivityLevel.level_6.name;} break;
    }
  }



  void nextPage(){
    if(_page <= 2){
      _page++;
      notifyListeners();
    }
  }

  void setGender(bool? gender){
    _gender = gender;
    if(_gender!) _sex = "female";
    else _sex = "male";
    notifyListeners();
  }

  void previousPage(){
    if(_page >= 0){
      _page--;
      notifyListeners();
    }
  }






}