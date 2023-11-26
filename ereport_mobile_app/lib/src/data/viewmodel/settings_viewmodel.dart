import 'dart:async';
import 'package:ereport_mobile_app/src/core/constants/activity_level.dart';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

class SettingsViewModel extends ChangeNotifier {

  final auth = Auth();
  late StreamSubscription<User?> _sub;
  late UserModel _user;
  late final Firestore firestore;
  String _sex = 'male';
  late String _tempActivityLevel;
  String? _email;
  Gender _gender = Gender.male;
  ResultState _state = ResultState.loading;

  UserModel get user => _user;
  ResultState get state => _state;
  String? get email => _email;
  Gender get gender => _gender;
  String get sex => _sex;
  String get activityLevel => _tempActivityLevel;


  SettingsViewModel(){
    _user = UserModel.createFirstTime();
    firestore = Firestore();
  }

  void init(){
    getUser();
    _sub = auth
        .authStateChanges
        .listen((User? user) {
      if (user == null) {
        _state = ResultState.unLogged;
        notifyListeners();
      } else {
        print('logout failed');
      }
    });
  }

  set name(String inputName) {
    _user.name = inputName;
  }

  set weight(String weight){
    _user.weight = double.tryParse(weight);
  }

  set height(String height){
    _user.height = double.tryParse(height);
  }

  set calorieNeed(String calorieNeed){
    _user.calorieNeed = double.tryParse(calorieNeed);
  }


  void setGender(String sex) {
    _sex = sex;
    if(sex == 'male') _user.gender = false;
    else _user.gender = true;
    notifyListeners();
  }

  void initActivityLevel() {
    // ActivityLevel.values.forEach((element) {
    //   if(element.name == _user.activityLevel) {
    //     _tempActivityLevel = activityLevelText[element.index];
    //   }
    // });
    activityLevelMap.forEach((key, value) {
      if(key.name == _user.activityLevel) _tempActivityLevel = value;
    });

  }




  // cant use switch and enum because switch case statement must be constant values, so i use if-else
  // needs to be improved next
  void setActivityLevel(String actLevel) {
    activityLevelMap.forEach((key, value) {
      if(value == actLevel) _tempActivityLevel = value;
    });
    notifyListeners();
  }

  Future<void> updateProfileData() async {

  }



  Future<void> getUser() async {
    final uid = await auth.getCurrentUID();
    final result = await firestore.getUserData(uid!);
    _user = result!;
    _email = auth.currentUser!.email!;
    initActivityLevel();
    notifyListeners();

  }

  void dispose(){
    _state = ResultState.loading;
    notifyListeners();
  }

  Future<void> logOut() async {
    await auth.signOut();
  }


}