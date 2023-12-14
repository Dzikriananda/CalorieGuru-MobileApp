import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/styles/text_style.dart';
import '../../../../../../data/models/list_log_model.dart';

class RecentItem extends StatelessWidget {
  final LogModel content;
  final bool touchable;
  final VoidCallback onTapped;
  final VoidCallback onNavigate;

  const RecentItem({Key? key,required this.content,required this.onTapped,required this.touchable,required this.onNavigate}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: InkWell(
        onTap: () async {
          onNavigate();
          if (touchable) {
            final result = await Navigator.pushNamed(context, '/listScreen',arguments: {'name': content.type,'isUpdate': true,'data':content});
            if(result == true || result != null) {
              onTapped();
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: borderColor_1,
            borderRadius:  BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1), //0.5
                blurRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextStrings.recenItemWidget_1(content.type!, content.instanceType!),style: listActivityText,textAlign: TextAlign.start),
                    Text(TextStrings.recenItemWidget_2(content.instanceName!),style: listActivityText2),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Text(TextStrings.recenItemWidget_3(content.type!, content.calories),style: listActivityText2),
            ],
          ),
        ),
      )
    );
  }
}