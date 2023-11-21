import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SystemViewModel extends ChangeNotifier {

  Color _bottomNavBarColor = primaryColor;
  Brightness _bottomNavBarButtonColor = Brightness.light;

  Color get bottomNavBarColor => _bottomNavBarColor;
  Brightness get bottomNavBarButtonColor => _bottomNavBarButtonColor;

  void mainBottomNavColor(){
    _bottomNavBarColor = primaryColor;
    _bottomNavBarButtonColor = Brightness.light;
    notifyListeners();
  }

  void lightBottomNavColor(){
    _bottomNavBarColor = Colors.white;
    _bottomNavBarButtonColor = Brightness.dark;
    notifyListeners();
  }




}