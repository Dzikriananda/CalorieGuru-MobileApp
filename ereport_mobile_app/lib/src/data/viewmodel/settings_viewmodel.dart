import 'dart:async';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';

import '../../core/constants/text_strings.dart';

class SettingsViewModel extends ChangeNotifier {

  late Auth auth;
  late StreamSubscription<User?> _sub;
  late UserModel _user;
  late final Firestore firestore;
  late String _tempGenderString;
  late bool _temporaryGender;
  late String _tempActivityLevel;
  late DateTime _tempDate;
  String? _email;
  late Gender _gender;
  late ResultState _state;
  String? _inputPassword;
  String? _newEmail;
  String? _newPassword;
  late String _errorMessage;

  UserModel get user => _user;
  ResultState get state => _state;
  String? get email => _email;
  Gender get gender => _gender;
  String? get newEmail => _newEmail;
  String get tempGender => _tempGenderString;
  String get errorMessage => _errorMessage;
  bool get temporaryGender => _temporaryGender;
  String get tempActivityLevel => _tempActivityLevel;
  DateTime get tempDate => _tempDate;


  SettingsViewModel(){
    _user = UserModel.createFirstTime();
    firestore = Firestore();
    auth = Auth();
    _errorMessage = '';
    _gender = Gender.male;
    _state = ResultState.started;
  }

   set setPassword(String inputPassword) {
    _inputPassword = inputPassword;
   }

  set setNewEmail(String inputEmail) {
    _newEmail = inputEmail;
  }

  set setNewPassword(String inputPassword) {
    _newPassword = inputPassword;
  }

   Future<void> authenticate() async {
    _state = ResultState.loading;
    notifyListeners();
     try {
       final userCredential = await auth.authenticateSettings(email: auth.currentUser!.email!, password: _inputPassword!);
       _state = ResultState.hasData;
     } on FirebaseAuthException catch (e) {
       switch(e.code) {
         case 'INVALID_LOGIN_CREDENTIALS':
           _state = ResultState.wrongCredential;
           _errorMessage = TextStrings.enterAuthenticationScreen_2;
           break;
         case 'too-many-requests':
           _state = ResultState.error;
           _errorMessage = TextStrings.enterAuthenticationScreen_3;
           break;
         default:
           _errorMessage = TextStrings.enterAuthenticationScreen_4;
           _state = ResultState.error;

       }
     } catch (e) {
       _state = ResultState.error;
       _errorMessage = TextStrings.enterAuthenticationScreen_4;
     }
     notifyListeners();
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
        debugPrint('logout failed');
      }
    });
  }

  set tempDate(DateTime date) {
    _tempDate = date;
    notifyListeners();
  }

  set resultState(ResultState resultState) {
    _state = resultState;
    notifyListeners();
  }


  void setGender(String sex) {
    _tempGenderString = sex;
    if(sex == Gender.male.name) {
      _temporaryGender = false;
    } else {
      _temporaryGender = true;
    }
    notifyListeners();
  }

  void initActivityLevel() {
    activityLevelMap.forEach((key, value) {
      if(key.name == _user.activityLevel) _tempActivityLevel = value;
    });
  }

  void initDateTime() {
    _tempDate = DateTime.parse(_user.birthdate!);
  }

  void initGender() {
    _tempGenderString = (_user.gender!) ? Gender.female.name : Gender.male.name;
    _temporaryGender = _user.gender!;
  }

  // cant use switch and enum because switch case statement must be constant values, so i use if-else
  // needs to be improved next
  void setActivityLevel(String actLevel) {
    activityLevelMap.forEach((key, value) {
      if(value == actLevel) _tempActivityLevel = value;
    });
    notifyListeners();
  }

  String getActivityLevel() {
    late String activityLevel;
    activityLevelMap.forEach((key, value) {
      if(value == _tempActivityLevel) activityLevel = key.name;
    });
    return activityLevel;
  }

  Future<bool> updateProfileData(
      String name,
      String weight,
      String height,
      String calorieNeed,
      ) async {
    _state = ResultState.loading;
    notifyListeners();
    try {
      final weightInput = double.parse(weight);
      final heightInput = double.parse(height);
      final calorieInput = double.parse(calorieNeed);
      user.name = name;
      user.gender = _temporaryGender;
      user.weight = double.parse(weightInput.toStringAsFixed(1));
      user.height = double.parse(heightInput.toStringAsFixed(1));
      user.calorieNeed = double.parse(calorieInput.toStringAsFixed(1));
      user.birthdate = _tempDate.toString();
      user.activityLevel = getActivityLevel();
      final uid = await auth.getCurrentUID();
      final result =  await firestore.updateUser(uid!, user);
      if(result == true) {
        await firestore.updateTodayLogCalorieBudget(uid, user.calorieNeed!);
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
    catch(e) {
      debugPrint(TextStrings.errorRuntime('updateProfiledATA', 'settings_viewmodel.dart', e.toString()));
      _state = ResultState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> getUser() async {
    final uid = await auth.getCurrentUID();
    final result = await firestore.getUserData(uid!);
    _user = result!;
    _email = auth.currentUser!.email!;
    initActivityLevel();
    initDateTime();
    initGender();
    notifyListeners();
  }

  Future<void> changePassword() async {
    _state = ResultState.loading;
    notifyListeners();
    try {
      await auth.changePassword(newPassword: _newPassword!);
      _state = ResultState.changeSuccess;
    }
    catch(e) {
      debugPrint(TextStrings.errorRuntime('ChangePassword', 'settings_viewmodel.dart', e.toString()));
      _state = ResultState.error;
    }
    notifyListeners();
  }

  Future<void> changeEmail() async {
    await auth.changeEmail(newEmail: _newEmail!);
  }

  Future<void> deleteAccount() async {
    await auth.deleteAccount();
  }

  Future<void> verifyEmail() async {
    await auth.verifyEmail(newEmail: _newEmail!);
  }

  void disposeViewModel(){
    _state = ResultState.started;
    _sub.cancel();
    notifyListeners();
  }

  Future<void> logOut() async {
    await auth.signOut();
  }



}