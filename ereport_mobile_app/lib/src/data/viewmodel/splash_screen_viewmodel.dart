import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class SplashScreenViewModel extends ChangeNotifier {


  ResultState _state = ResultState.loading;

  ResultState get state => _state;

  SplashScreenViewModel(){}

}