import 'package:flutter/material.dart';

import '../../../../../../core/styles/text_style.dart';
import '../../../../../../data/models/list_log_model.dart';

class RecentItem extends StatelessWidget {
  LogModel content;
  VoidCallback onTapped;

  RecentItem({Key? key,required this.content,required this.onTapped}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: InkWell(
        onTap: () async {
          debugPrint(content.no.toString());
          final result = await Navigator.pushNamed(context, '/listScreen',arguments: {'name': content.type,'isUpdate': true,'data':content});
          if(result == true || result != null) {
            onTapped();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:  BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2,
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((content != null)? "${content.type!} - ${content.instanceType!}" : '',style: listActivityText,textAlign: TextAlign.start),
                        Text((content != null)? "${content.instanceName!} " : '',style: listActivityText2),
                      ],
                    ),
                  )
              ),
              const SizedBox(width: 5),
              Text((content.type == 'Meal') ? '+${content.calories} Kcal ' : '-${content.calories} Kcal ',style: listActivityText2),
              // Icon(Icons.fastfood_sharp,size: 40),

            ],
          ),
        ),
      )
    );
  }
}