
import 'package:flutter/material.dart';



class AboutAppPadding extends StatelessWidget {
  Widget widget;
  AboutAppPadding({Key? key,required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
      child: widget
    );
  }
}