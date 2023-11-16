import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/screen_type.dart';

class NotFoundWidget extends StatelessWidget {
  final ScreenType type;
  const NotFoundWidget({Key? key,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width ,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: primaryContainer,
          ),
          child: Column(
            children: [
              Image.asset(
                DefaultImages.not_found_image,
                height: 150,
                width: 150,
              ),
              Text((type == ScreenType.Meal) ? TextStrings.notFound_1 : TextStrings.notFound_2,style: notFoundText,textAlign: TextAlign.center,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: onPrimaryColor,
                  shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
                onPressed: () {
                  (type == ScreenType.Meal) ? Navigator.pop(context,false) : Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          )
      ),
    );
  }
}