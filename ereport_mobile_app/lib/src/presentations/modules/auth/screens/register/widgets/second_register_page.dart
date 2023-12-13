import 'package:ereport_mobile_app/src/core/constants/activity_options.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import '../../../widgets/activity_button.dart';

class SecondRegisterWidget extends StatefulWidget {
  const SecondRegisterWidget({Key? key}) : super(key: key);

  @override
  State<SecondRegisterWidget> createState() => _SecondRegisterWidgetState();
}

class _SecondRegisterWidgetState extends State<SecondRegisterWidget> {

  List<String> options = ActivityOptions.activityOptions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<RegisterViewModel>(
          builder: (context,viewmodel,child) {
            return Center(
              child: Column(
                children: [
                  Text(TextStrings.registerScreen_9,style: petrolabTextTheme.bodyLarge),
                  ...options.mapIndexed((index,e) => ActivityOptionsButton(title: e,index: index)).toList(),
                  Visibility(
                      visible: viewmodel.visible3 ,
                      child: const Text(
                        TextStrings.invalidNullOptionWarning,
                        style: TextStyle(
                            color: Colors.red
                        ),
                      )
                  ),
                ],
              ),
            );
          }
        )
    );
  }
}