import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../../widgets/activity_button.dart';

class SecondRegisterWidget extends StatefulWidget {
  const SecondRegisterWidget({Key? key}) : super(key: key);

  @override
  State<SecondRegisterWidget> createState() => _SecondRegisterWidgetState();
}

class _SecondRegisterWidgetState extends State<SecondRegisterWidget> {

  List<String> options =[
    "Sedentary: little or no exercise",
    "Exercise 1-3 times/week",
    "Exercise 4-5 times/week",
    "Daily exercise or intense exercise 3-4 times/week",
    "Intense exercise 6-7 times/week",
    "Very intense exercise daily, or physical job"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Choose your activity level",style: petrolabTextTheme.bodyLarge),
              ...options.mapIndexed((index,e) => ActivityOptionsButton(title: e,index: index)).toList(),
            ],
          ),
        )
    );
  }
}