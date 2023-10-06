import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery. of(context). size. width.toString());
    return Scaffold(
        body: Center(
          child: Text(
            "ini halaman settings",
            style: petrolabTextTheme.headlineLarge,
          ),
        )
    );
  }
}




