import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/result_state.dart';
import '../../../../../core/constants/text_strings.dart';
import '../../../../../core/styles/color.dart';
import '../../../../../core/styles/text_style.dart';

class EnterAuthenticationScreen extends StatefulWidget {
  const EnterAuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<EnterAuthenticationScreen> createState() => _EnterAuthenticationScreenState();
}

class _EnterAuthenticationScreenState extends State<EnterAuthenticationScreen> {

  final _formKey = GlobalKey<FormState>();
  late bool isDelete;

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    isDelete = ModalRoute.of(context)!.settings.arguments as bool;
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (_) {
          context.read<SettingsViewModel>().resultState = ResultState.started;
        },
        child: Scaffold(
            body: SafeArea(
                child: Consumer<SettingsViewModel>(
                    builder: (context,viewmodel,child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                                child: Column(
                                  children: [
                                    Text(TextStrings.enterAuthenticationScreen_1,textAlign: TextAlign.center,style: petrolabTextTheme.titleMedium,),
                                    const SizedBox(height: 15),
                                    Form(
                                      key: _formKey,
                                      child: CustomFormField(
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: onPrimaryContainer),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue, width: 2),
                                          ),
                                          focusedErrorBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue, width: 2),
                                          ),
                                          errorBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 2),
                                          ),
                                          style: profileScreenTextStyle,
                                          readOnly: false,
                                          onTap: () {},
                                          suffixIcon: null,
                                          margin: 1.0,
                                          hasUnderline: true,
                                          maxLines: 1,
                                          initialValue: null,
                                          backgroundColor: backgroundColor,
                                          isEnabled: true,
                                          hintText: "Password",
                                          icon: const Icon(Icons.lock),
                                          isPassword: true,
                                          validator: (val) {
                                            if (!val!.isNotNull) {
                                              return TextStrings.invalidNullWarning;
                                            } else if (!val.isValidPassword) {
                                              return TextStrings.invalidPasswordWarning;
                                            }
                                            return null;
                                          },
                                          onSubmited: (value){
                                            viewmodel.setPassword = value;
                                          },
                                          textfieldController: null
                                      ),
                                    ),
                                    Visibility(
                                        visible: (viewmodel.state == ResultState.wrongCredential || viewmodel.state == ResultState.error),
                                        child: Text(viewmodel.errorMessage,style: chooseItemTextError)
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                              await viewmodel.authenticate();
                                              if (viewmodel.state == ResultState.hasData) {
                                                (isDelete) ? Navigator.pushReplacementNamed(context, '/deleteAccountScreen') : Navigator.pushReplacementNamed(context, '/selectEditAuthenticationScreen');
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            backgroundColor: primaryColor,
                                          ),
                                          child: const Text(TextStrings.editAuthenticationScreen_8,style: TextStyle(color: onPrimaryColor)),
                                        )
                                    ),

                                  ],
                                ),
                              )
                          ),
                          Visibility(
                            visible: (viewmodel.state == ResultState.loading),
                            child: const CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        ],
                      );
                    }
                )
            )
        )
    );
  }
}