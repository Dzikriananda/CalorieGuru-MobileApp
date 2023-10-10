import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/login_form_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String firstPassword;
  late String secondPassword;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Column(
                      children: [
                        Image.asset(
                          DefaultImages.logo,
                          height: 120,
                          width: 120,
                        ),
                        Text(
                            TextStrings.appTitle,
                            style: splashScreenText
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
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
                        Text("Register", style: LoginScreenText),
                        const SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomFormField(
                                hintText: 'Enter Your Email',
                                validator: (val) {
                                  if (!val!.isValidEmail) return TextStrings.invalidEmailWarning;
                                },
                                isPassword: false,
                                onSubmited: (value){
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomFormField(
                                hintText: 'Enter Your Password',
                                validator: (val) {
                                  if (!val!.isValidPassword) return TextStrings.invalidPasswordWarning;
                                },
                                isPassword: true,
                                onSubmited: (value){
                                  setState(() {
                                    firstPassword = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomFormField(
                                hintText: 'Reenter Password',
                                validator: (val) {
                                  if (!val!.isValidPassword) return TextStrings.invalidPasswordWarning;
                                },
                                isPassword: true,
                                onSubmited: (value){
                                  setState(() {
                                    secondPassword = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate() && (firstPassword == secondPassword)){
                                    //signIn();
                                    Navigator.of(context).pushNamedAndRemoveUntil('/bottomNavigation', (Route route) => false);
                                  }
                                },
                                child: Text("Register",style: LoginButtonText),
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
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        )

    );
  }
}

