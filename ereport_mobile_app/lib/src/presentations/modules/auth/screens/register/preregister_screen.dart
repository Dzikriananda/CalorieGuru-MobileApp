import 'dart:ui';

import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/widgets/next_button_widget.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/register_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
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
                'assets/images/register_onboarding1.png',
                height: 150,
                width: 150,
              ),
              Text(
                'Congrats,',
                style: registerOnBoardingWelcomeText,
                textAlign: TextAlign.center,
              ),
              Text(
                'Your Accounts Has Been Created!',
                style: registerOnBoardingWelcomeText,
                textAlign: TextAlign.center,
              ),
              SizedBox(height : 20),
              Text(
                'In order to find the best choice\nfor you, please fill these required data',
                style: petrolabTextTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: "next",
                    child: ElevatedButton(
                      child: Text("  Next  ",style: TextStyle(color: onPrimaryColor)),
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