import 'dart:async';
import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/constants/global.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/auth_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget{
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInState();
}

class _SignInState extends State<SignInForm>{
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }



  void changeScreen(ResultState state,Function disposeFunc){
    if(state == ResultState.logged ){
      disposeFunc();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil('/bottomNavigation', (Route route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final viewModel = Provider.of<AuthViewModel>(context, listen: true);
    changeScreen(viewModel.state,()=>viewModel.dispose());
    return Container(
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
                  icon: Icon(Icons.email),
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
                  icon: Icon(Icons.lock),
                  onSubmited: (value){
                    viewModel.setPwd = value;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    print("menekan login");
                    if(_formKey.currentState!.validate()){
                      print("berhasil login");
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
    );
  }
}