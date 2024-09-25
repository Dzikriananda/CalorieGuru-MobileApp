import 'dart:async';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/auth_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget{
  final bool isFromSplash;
  const SignInForm({super.key,required this.isFromSplash});

  @override
  State<SignInForm> createState() => _SignInState();
}

class _SignInState extends State<SignInForm>{
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;

  @override
  void initState()  {
    super.initState();
    enableTextField();
  }

  //harus didelay karena akan overflow jika disentuh saat animasi masih berjalan
  Future<void> enableTextField() async{
    if(widget.isFromSplash){
      Future.delayed(const Duration(milliseconds: 1800),(){
        setState(() {
          isEnabled = true;
        });
      });
    }
    else{
      setState(() {
        isEnabled = true;
      });
    }
  }



  void changeScreen(ResultState state,Function disposeFunc){
    if(state == ResultState.logged){
      disposeFunc();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil('/bottomNavigation', (Route route) => false);
      });
    }
    else if(state == ResultState.loggedNotFilledData){
      disposeFunc();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil('/registerScreen', (Route route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    final viewModel = Provider.of<AuthViewModel>(context, listen: true);
    changeScreen(viewModel.state,()=>viewModel.disposeViewModel());

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: primaryContainer,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: primaryContainer
          ),
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              const Text(TextStrings.signInForm_1, style: LoginScreenText),
              SizedBox(height: MediaQuery.of(context).size.height * 0.035),
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
                      hintText: TextStrings.signInForm_2,
                      validator: (val) {
                        if (!val!.isValidEmail) return TextStrings.invalidEmailWarning;
                        return null;
                      },
                      isPassword: false,
                      icon: const Icon(Icons.email),
                      onSubmited: (value){
                        viewModel.setEmail = value;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015),
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
                      hintText: TextStrings.signInForm_3,
                      validator: (val) {
                        if (!val!.isValidPassword) return TextStrings.invalidPasswordWarning;
                        return null;
                      },
                      isPassword: true,
                      icon: const Icon(Icons.lock),
                      onSubmited: (value){
                        viewModel.setPwd = value;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                    ElevatedButton(
                      onPressed: () {
                        if(!viewModel.isLoading) {
                          if(_formKey.currentState!.validate()){
                            viewModel.signInWithEmailAndPassword();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(TextStrings.signInForm_4,style: LoginButtonText),
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.8,
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child:  Container(
                    //           height: 2,
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //       SizedBox(width: 5),
                    //       Text('Or Login With',style: Theme.of(context).textTheme.titleSmall),
                    //       SizedBox(width: 5),
                    //       Expanded(
                    //         child: Container(
                    //           height: 2,
                    //           color: Colors.grey,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // OutlinedButton(
                    //     onPressed: () {
                    //
                    //     },
                    //     style: ButtonStyle(
                    //       shape: MaterialStateProperty.all(
                    //         RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(15.0),
                    //           // side: BorderSide(color: Colors.red),
                    //         ),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Text('Sign in with Google'),
                    //         SizedBox(width: 10),
                    //         FaIcon(FontAwesomeIcons.google)
                    //       ],
                    //     )
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     viewModel.signInWithGoogle();
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: primaryColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    //   child: FaIcon(FontAwesomeIcons.google,color: Colors.white),
                    // ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            if(!viewModel.isLoading) {
              viewModel.signInWithGoogle();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Login with Google',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white
              )),
              SizedBox(width: 10),
              FaIcon(FontAwesomeIcons.google,color: Colors.white)
            ],
          ),
        ),
      ],
    );
  }
}