import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class FirstOnboardingWidget extends StatelessWidget {

  const FirstOnboardingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: [
          Image.asset(
            DefaultImages.first_onboarding_image,
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width * 0.38
          ),
          Text(
            TextStrings.firstOnboarding_1,
            style: onBoardingWelcomeText,
            textAlign: TextAlign.center,
          ),
          Text(
            TextStrings.firstOnboarding_2,
            style: petrolabTextTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            TextStrings.firstOnboarding_3,
            style: petrolabTextTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}