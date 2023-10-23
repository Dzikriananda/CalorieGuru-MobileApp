import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/auth_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/auth/widgets/register_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/auth/widgets/signin_form.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool _visible = false;
  bool isRegister = false;
  bool isFromSplashScreen = true;

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
    setState(() {
      _visible = false;
      isFromSplashScreen = false;
    });
    Future.delayed(Duration(milliseconds: 500), () { // <-- Delay here
      setState(() {
        isRegister = !isRegister;
        _visible = true;
      });
    });

  }

  void showSnackBar(String? errormessage, Function setStatus){
    final snackBar = SnackBar(
      content: Column(
        children: [
          const Row(
            children: [
              const Icon(
                Icons.warning,
                color: Colors.red,
                size: 22,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                "Login Failed!",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                    color: Colors.red),
              ),
            ],
          ),
          Text("Error : $errormessage")
        ],
      ),
      backgroundColor: primaryColor,
      duration: const Duration(seconds: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setStatus();
  }


  @override
  Widget build(BuildContext context){
    final viewModel = Provider.of<AuthViewModel>(context, listen: true);
    if(viewModel.state == ResultState.error){
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        showSnackBar(
            viewModel.errorMessage,
            () => viewModel.setViewModelState = ResultState.hasData
        );
      });
    }
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
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            DefaultImages.logo,
                            height: 150,
                            width: 150,
                          ),
                          // const Text(
                          //     TextStrings.appTitle,
                          //     style: splashScreenText
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: isRegister ? RegisterForm() : SignInForm(isFromSplash: isFromSplashScreen)
                      ),
                      Visibility(
                          visible: viewModel.state == ResultState.loading,
                          child: const CircularProgressIndicator(
                            color: onPrimaryContainer,
                          ),
                      )
                    ],
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
                                style: const TextStyle(color: Colors.blue),
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
                                style: const TextStyle(color: Colors.blue),
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

