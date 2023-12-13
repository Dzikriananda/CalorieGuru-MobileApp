import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/widgets/first_onboarding_widget.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/widgets/next_button_widget.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/widgets/second_onboarding_widget.dart';
import 'package:flutter/material.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isTapped = false;
  bool isVisible = false;
  int currentPages = 0;

  @override
  void initState(){
    super.initState();
    showInitWidget();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
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
    if(currentPages == 1){
      Navigator.pushReplacementNamed(context, '/authScreen');
    }
    else{
      Future.delayed(Duration(milliseconds: 500), () { // <-- Delay here
        setState(() {
          if(currentPages != 1) currentPages++;
          isVisible = true;
        });
      });
    }
  }

  Future<bool> onPressedBack() async {
    if(currentPages != 0){
      hideWidget();
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
                          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 0),
                          child: Column(
                            children: [
                              Image.asset(
                                DefaultImages.logo,
                                height: MediaQuery.of(context).size.height * 0.17, //default 150 h&w
                                width: MediaQuery.of(context).size.width * 0.38
                              ),
                              // Text(TextStrings.appTitle, style: splashScreenText),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06), //def 50
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

// height: MediaQuery.of(context).size.height * 0.18, //default 150 h&w
// width: MediaQuery.of(context).size.height * 0.18,