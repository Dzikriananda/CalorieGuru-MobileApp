import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class SecondOnboardingWidget extends StatelessWidget {
  const SecondOnboardingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260, //bermasal
      child: Column(
        children: [
          Image.asset(
            DefaultImages.second_onboarding_image,
            height: 150,
            width: 150,
          ),
          Text(
            TextStrings.secondOnboarding_1,
            style: onBoardingWelcomeText,
            textAlign: TextAlign.center,
          ),
          Text(
            TextStrings.secondOnboarding_2,
            style: petrolabTextTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}