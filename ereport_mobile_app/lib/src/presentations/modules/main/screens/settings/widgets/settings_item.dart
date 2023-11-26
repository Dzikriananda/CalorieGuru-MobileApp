import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  const SettingsItem({Key? key,required this.onPressed,required this.title,required this.icon}) : super(key: key);

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Icon(widget.icon,size: 30),
                      width: 50,
                      height: 50,
                    ),
                    Text(widget.title,style: settingsItem,),
                  ],
                ),
                Expanded(child: SizedBox()),
                IconButton(
                    onPressed: (){
                      widget.onPressed();
                    },
                    icon: Icon(Icons.arrow_forward_ios)
                )
              ],
            ),
            Container(
              height: 0.5,
              color: Colors.grey,
            )
          ],
        )
    );
  }
}