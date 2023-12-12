import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:flutter/material.dart';

import '../../core/styles/color.dart';

class CustomAlertDialog extends StatefulWidget {
  final VoidCallback onRetry;
  String content;
  Icon icon;
  String buttonText;
  CustomAlertDialog({Key? key,required this.onRetry,required this.content,required this.icon,required this.buttonText}) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(TextStrings.alertTitle),
      content: Text(widget.content,textAlign: TextAlign.center),
      icon: widget.icon,
      actions: [
        TextButton(
          onPressed: widget.onRetry,
          child: Container(
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: const EdgeInsets.all(14),
            child: Text(
              widget.buttonText,
              style: TextStyle(color: onPrimaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

