import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState(){
    super.initState();
    final stat_awal = Provider.of<SettingsViewModel>(context, listen: false).state;
    print("state saat init : $stat_awal");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<SettingsViewModel>(context, listen: false).init();
    });
  }

  final snackBar = SnackBar(
    content: const Text('Notification'),
    backgroundColor: primaryColor,
    duration: const Duration(seconds: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    action: SnackBarAction(
      label: TextStrings.loggedOutText,
      textColor: onPrimaryColor,
      onPressed: () {},
    ),
  );


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsViewModel>(context, listen: true);
    if(provider.state == ResultState.unLogged){
      print('logout dengan status = ${provider.state}');
      SchedulerBinding.instance.addPostFrameCallback((_) {
        provider.dispose();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/authScreen', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
    return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: provider.logOut,
            child: const Text('Logout'),
          ),
        )
    );
  }
}




