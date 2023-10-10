import 'dart:async';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/login_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/login_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget{
  final bool isVisible;
  const SignInForm({super.key,required this.isVisible});

  @override
  State<SignInForm> createState() => _SignInState();
}

class _SignInState extends State<SignInForm>{
  final _formKey = GlobalKey<FormState>();
  final User? user = Auth().currentUser;
  late StreamSubscription<User?> auth;


  String _email = "dzikri@gmail.com";
  String _pwd = "12345678";

  Future<void> checkUID() async {
    var uid = await Auth().getCurrentUID();
    print("uid : $uid");
  }

  @override
  void initState() {
    super.initState();
    // final uid = Auth().getCurrentUID();
    auth = Auth().authStateChanges.listen((event) {
      print("event: $event");
    });
    print("user : $user");
    checkUID();
  }

  void changeScreen(ResultState state,Function disposeFunc){
    print("state changescreen $state");
    if(state == ResultState.logged ){
      print("state changescreen moving...$state");
      disposeFunc();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil('/bottomNavigation', (Route route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final viewModel = Provider.of<LoginViewModel>(context, listen: true);
    changeScreen(viewModel.state,()=>viewModel.dispose());
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
                    opacity: widget.isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryContainer,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: primaryContainer
                      ),
                      width: 350,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text("Login", style: LoginScreenText),
                          const SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomFormField(
                                  hintText: 'Email',
                                  validator: (val) {
                                    if (!val!.isValidEmail) return TextStrings.invalidEmailWarning;
                                  },
                                  isPassword: false,
                                  onSubmited: (value){
                                    viewModel.setEmail = value;
                                  },
                                ),
                                const SizedBox(height: 15),
                                CustomFormField(
                                  hintText: 'Password',
                                  validator: (val) {
                                    if (!val!.isValidPassword) return TextStrings.invalidPasswordWarning;
                                  },
                                  isPassword: true,
                                  onSubmited: (value){
                                    viewModel.setPwd = value;
                                  },
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()){
                                      viewModel.signIn();
                                    }
                                  },
                                  child: Text("Login",style: LoginButtonText),
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  AnimatedOpacity(
                    opacity: widget.isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child:  RichText(
                      text: TextSpan(
                        text: TextStrings.signinregister_first,
                        style: registerOptionText,
                        children: [
                          TextSpan(
                              text: TextStrings.signinregister_second,
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).pushNamed('/registerScreen')
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