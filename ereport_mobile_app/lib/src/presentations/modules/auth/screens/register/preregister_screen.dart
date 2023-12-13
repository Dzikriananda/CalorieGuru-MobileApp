import 'dart:ui';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../core/styles/text_style.dart';

class PreRegisterScreen extends StatefulWidget {
  const PreRegisterScreen({Key? key}) : super(key: key);

  @override
  State<PreRegisterScreen> createState() => _PreRegisterScreenState();
}

class _PreRegisterScreenState extends State<PreRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Image.asset(
                DefaultImages.registerOnboarding_1,
                height: 150,
                width: 150,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                child: Text(
                  TextStrings.registerOnBoardingScreen_1,
                  style: registerOnBoardingWelcomeText,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height : 20),
              Text(
                TextStrings.registerOnBoardingScreen_2,
                style: petrolabTextTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: "next",
                    child: ElevatedButton(
                      child: const Text(TextStrings.registerOnBoardingScreen_3,style: TextStyle(color: onPrimaryColor)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}