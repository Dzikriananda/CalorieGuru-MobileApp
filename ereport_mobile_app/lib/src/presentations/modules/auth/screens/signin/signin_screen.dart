import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/signin/widgets/signin_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  // late bool isConnected;
  bool _visible = false;

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


  @override
  Widget build(BuildContext context) {
    return SignInForm(isVisible: _visible,);
  }
}

