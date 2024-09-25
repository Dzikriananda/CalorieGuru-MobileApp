import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/auth_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/result_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = true;


  @override
  void initState() {
    super.initState();
  }

  void changeScreen(ResultState state,Function disposeFunc){
    if(state == ResultState.loggedNotFilledData){
      disposeFunc();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/registerScreen');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context, listen: true);
    changeScreen(viewModel.state,()=>viewModel.disposeViewModel());

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: primaryContainer,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: primaryContainer
      ),
      width: 350,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(TextStrings.registerForm_1, style: LoginScreenText),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  readOnly: false,
                  onTap: () {},
                  suffixIcon: null,
                  margin: 8.0,
                  hasUnderline: false,
                  maxLines: 1,
                  initialValue: null,
                  isEnabled: isEnabled,
                  backgroundColor: backgroundColor,
                  hintText: TextStrings.registerForm_2,
                  validator: (val) {
                    if (!val!.isValidEmail) return TextStrings.invalidEmailWarning;
                    return null;
                  },
                  isPassword: false,
                  icon: const Icon(Icons.email),
                  onSubmited: (value){
                    Provider.of<AuthViewModel>(context, listen: false).setEmail=value;
                  },
                ),
                const SizedBox(height: 15),
                CustomFormField(
                  readOnly: false,
                  onTap: () {},
                  suffixIcon: null,
                  margin: 8.0,
                  hasUnderline: false,
                  maxLines: 1,
                  initialValue: null,
                  isEnabled: isEnabled,
                  backgroundColor: backgroundColor,
                  hintText: TextStrings.registerForm_3,
                  validator: (val) {
                    if (!val!.isValidPassword) return TextStrings.invalidPasswordWarning;
                    return null;
                  },
                  isPassword: true,
                  icon: const Icon(Icons.lock),
                  onSubmited: (value){
                    setState(() {
                      Provider.of<AuthViewModel>(context, listen: false).setPwd=value;
                    });
                  },
                ),
                const SizedBox(height: 15),
                CustomFormField(
                  readOnly: false,
                  onTap: () {},
                  suffixIcon: null,
                  margin: 8.0,
                  hasUnderline: false,
                  maxLines: 1,
                  initialValue: null,
                  isEnabled: isEnabled,
                  backgroundColor: backgroundColor,
                  hintText: TextStrings.registerForm_4,
                  validator: (val) {
                    if (!val!.isValidPassword) return TextStrings.invalidPasswordWarning;
                    return null;
                  },
                  isPassword: true,
                  icon: const Icon(Icons.lock),
                  onSubmited: (value){
                    setState(() {
                      Provider.of<AuthViewModel>(context, listen: false).setPwd2=value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate() && (
                        Provider.of<AuthViewModel>(context, listen: false).password == Provider.of<AuthViewModel>(context, listen: false).password_2)
                    ){
                      viewModel.isSignInWithGoogle = false;
                      viewModel.signUp();
                    }
                  },
                  child: const Text(TextStrings.registerForm_5,style: LoginButtonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
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

