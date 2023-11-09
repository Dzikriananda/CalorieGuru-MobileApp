import 'package:flutter/material.dart';

import '../../core/styles/color.dart';

class CustomAlertDialog extends StatefulWidget {
  final VoidCallback onRetry;
  CustomAlertDialog({Key? key,required this.onRetry}) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Alert"),
      content: Text("No Internet Connection!"),
      icon: Icon(Icons.signal_wifi_connected_no_internet_4_sharp),
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
              "Retry",
              style: TextStyle(color: onPrimaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

