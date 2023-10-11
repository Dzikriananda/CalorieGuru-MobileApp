import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/widgets/register_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/signin/widgets/signin_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool _visible = false;
  bool isRegister = false;

  @override
  void initState(){
    super.initState();
    showLoginForm();
  }

  Future<void> showLoginForm() async{
    Future.delayed(Duration(seconds: 1), () { // <-- Delay here
      setState(() {
        _visible = true;
      });
    });
  }

  void changeForm(){
    setState(() => _visible = false);
    Future.delayed(Duration(milliseconds: 500), () { // <-- Delay here
      setState(() {
        isRegister = !isRegister;
        _visible = true;
      });
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
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
                          Text(
                              TextStrings.appTitle,
                              style: splashScreenText
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: isRegister ? RegisterForm() : SignInForm()
                  ),
                  const SizedBox(height: 5),
                  AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child:  !isRegister ? RichText(
                        text: TextSpan(
                          text: TextStrings.signinregister_first,
                          style: registerOptionText,
                          children: [
                            TextSpan(
                                text: TextStrings.signinregister_second,
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => changeForm()
                            ),
                          ],
                        ),
                      ) : RichText(
                        text: TextSpan(
                          text: TextStrings.register_first,
                          style: registerOptionText,
                          children: [
                            TextSpan(
                                text: TextStrings.register_second,
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => changeForm()
                            ),
                          ],
                        ),
                      )

                  )
                ],
              ),
            ),
          ),
        )

    );
  }
}

