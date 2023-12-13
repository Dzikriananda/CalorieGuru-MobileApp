import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:flutter/material.dart';

class NextButtonWidget extends StatelessWidget {

  final VoidCallback onTap;

  const NextButtonWidget({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle
          ),
          height: MediaQuery.of(context).size.height * 0.06,
          child: Icon(
            Icons.navigate_next,
            size: MediaQuery.of(context).size.height * 0.06,
            color: onPrimaryColor,
          ),
        )
    );
  }
}