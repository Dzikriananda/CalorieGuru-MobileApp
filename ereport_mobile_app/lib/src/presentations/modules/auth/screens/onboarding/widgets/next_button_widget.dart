import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class NextButtonWidget extends StatelessWidget {

  final VoidCallback onTap;

  const NextButtonWidget({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle
          ),
          height: 50, //def 50
          child: Icon(
            Icons.navigate_next,
            size: 50,       //def 50
            color: onPrimaryColor,
          ),
        )
    );
  }
}