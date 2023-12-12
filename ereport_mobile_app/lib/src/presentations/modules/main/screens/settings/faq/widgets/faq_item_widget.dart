import 'package:ereport_mobile_app/src/data/models/faq_model.dart';
import 'package:flutter/material.dart';

class FaqItemWidget extends StatelessWidget {
  FaqItem item;

  FaqItemWidget({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: item.icon,
      title: Text(
        item.title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(25),
          child: Text(item.answer,textAlign: TextAlign.justify),
        )
      ],
    );
  }
}