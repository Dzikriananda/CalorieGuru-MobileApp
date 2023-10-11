import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
                  icon: Icon(Icons.email),
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
                  icon: Icon(Icons.lock),
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
                  icon: Icon(Icons.lock),
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
    );
  }
}

