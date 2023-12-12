import 'package:ereport_mobile_app/src/core/constants/activity_level.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ActivityType {
  running,
  climbing,
  hiking,
  cycling,
  ski
}

class ProfileAlertDialog extends StatefulWidget {
  String type;
  final VoidCallback onOk;

  ProfileAlertDialog({Key? key,required this.type,required this.onOk}) : super(key: key);

  @override
  State<ProfileAlertDialog> createState() => _ProfileAlertDialogState();
}

class _ProfileAlertDialogState extends State<ProfileAlertDialog> {
  late List<String> list;
  late var groupValue;

  // Due to Dart Limitation, I cant use Enum here, instead i using list/array

  @override
  void initState(){
    super.initState();
  }

  // int number(ActivityType input) {
  //   switch (input) {
  //     case ActivityType.running:
  //       return 1;
  //     case ActivityType.climbing:
  //       return 2;
  //     case ActivityType.hiking:
  //       return 5;
  //     case ActivityType.cycling:
  //       return 7;
  //     case ActivityType.ski:
  //       return 10;
  //   }
  // }  //inii

  @override
  void didChangeDependencies() {
    switch(widget.type) {
      case 'Gender' :
        list = Gender.values.map((e) => e.name).toList();
        groupValue = Provider.of<SettingsViewModel>(context,listen: true).tempGender;
        break;
      case 'ActivityLevel' :
        list = activityLevelText.map((e) => e).toList();
        groupValue = Provider.of<SettingsViewModel>(context,listen: true).tempActivityLevel;
        break;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext ctx) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(widget.type!),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...list.map((e) {
            return ListTile(
              title: Text(e),
              leading: Radio(
                value: e,
                groupValue: groupValue,
                onChanged: (value) {
                  switch(widget.type) {
                    case 'Gender' :
                      Provider.of<SettingsViewModel>(context,listen: false).setGender(value as String);
                      break;
                    case 'ActivityLevel' :
                      Provider.of<SettingsViewModel>(context,listen: false).setActivityLevel(value as String);
                      break;
                  }
                },
              ),
            );
          }).toList(),
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              widget.onOk();
              Navigator.of(ctx).pop();
            },
            child: Text("Choose",)
        ),
      ],
    );
  }
}


// ListTile(
// title: const Text('Male'),
// leading: Radio(
// value: Gender.male,
// groupValue: Provider.of<SettingsViewModel>(ctx).gender,
// onChanged: (value) {
// print(value);
// Provider.of<SettingsViewModel>(ctx,listen: false).gender = value!;
//
// },
// ),
// ),
// ListTile(
// title: const Text('Female'),
// leading: Radio(
// value: Gender.female,
// groupValue: Provider.of<SettingsViewModel>(ctx).gender,
// onChanged: (value) {
// print(value);
// Provider.of<SettingsViewModel>(ctx,listen: false).gender = value!;
// },
// ),
// ),

