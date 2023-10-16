import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/widgets/first_onboarding_widget.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/widgets/next_button_widget.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/widgets/second_onboarding_widget.dart';
import 'package:flutter/material.dart';

typedef MyBuilder = void Function(BuildContext context, void Function() methodA);

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late void Function() myMethod;
  bool isTapped = false;
  bool isVisible = false;
  int currentPages = 0;

  @override
  void initState(){
    super.initState();
    showInitWidget();
  }

  List<Widget> onBoardingPages = [
    FirstOnboardingWidget(),
    SecondOnboardingWidget()
  ];

  Future<void> showInitWidget() async{
    Future.delayed(Duration(seconds: 1), () { // <-- Delay here
      setState(() {
        isVisible = true;
      });
    });
  }

  void hideWidget() async{
    setState(() {
      isVisible = false;
    });
  }

  void onPressedNext(){
    hideWidget();
    if(currentPages < 1){
      Future.delayed(Duration(milliseconds: 500), () { // <-- Delay here
        setState(() {
          currentPages++;
          isVisible = true;
        });
      });
    } else{
      Navigator.pushReplacementNamed(context, '/authScreen');
    }
  }

  Future<bool> onPressedBack() async {
    hideWidget();
    if(currentPages != 0){
      Future.delayed(Duration(milliseconds: 500), () { // <-- Delay here
        setState(() {
          currentPages--;
          isVisible = true;
        });
      });
    }
    return Future.value(false);
  }


  @override
  Widget build(BuildContext context) {
      return WillPopScope(
          onWillPop: onPressedBack,
          child: SafeArea(
              child: Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                      Hero(
                        tag: Global.logoHeroTag,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: Column(
                            children: [
                              Image.asset(
                                DefaultImages.logo,
                                height: 150,
                                width: 150,
                              ),
                              // Text(TextStrings.appTitle, style: splashScreenText),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      AnimatedOpacity(
                        opacity: isVisible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: onBoardingPages[currentPages],
                      ),
                      NextButtonWidget(onTap: onPressedNext)
                    ],
                  )
              )
          )
      );
  }
}