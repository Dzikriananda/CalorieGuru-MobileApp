import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/login_form_field.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget{
  final bool isVisible;
  const SignInForm({super.key,required this.isVisible});


  @override
  State<SignInForm> createState() => _SignInState();
}

class _SignInState extends State<SignInForm>{
  final _formKey = GlobalKey<FormState>();


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
                              // height: 120,
                              // width: 120,
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
                                ),
                                const SizedBox(height: 15),
                                CustomFormField(
                                  hintText: 'Password',
                                  validator: (val) {
                                    if (!val!.isNotNull) return TextStrings.invalidPasswordWarning;
                                  },
                                  isPassword: true,
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()){
                                      Navigator.of(context).pushNamedAndRemoveUntil('/bottomNavigation', (Route route) => false);
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
                    child:  Text(
                        TextStrings.signinHelp,
                        style: Theme.of(context).textTheme.bodySmall
                    ),
                  )
                ],
              ),
            ),
          ),
        )

    );
  }
}