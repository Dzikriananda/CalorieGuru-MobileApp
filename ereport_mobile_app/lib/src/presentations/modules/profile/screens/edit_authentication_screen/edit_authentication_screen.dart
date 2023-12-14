import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/result_state.dart';
import '../../../../../core/constants/text_strings.dart';
import '../../../../../core/styles/color.dart';
import '../../../../../core/styles/text_style.dart';
import '../../../../global_widgets/alert_dialog.dart';

class EditAuthenticationScreen extends StatefulWidget {
  const EditAuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<EditAuthenticationScreen> createState() => _EditAuthenticationScreenState();
}

class _EditAuthenticationScreenState extends State<EditAuthenticationScreen> {
  late bool args;
  late String type;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as bool;
    (args) ? type = 'Password' : type = 'Email';
  }

  void _showAlertDialog(BuildContext context,String content,String buttonText,VoidCallback onClosed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            content: content,
            buttonText: buttonText,
            icon: Icon(Icons.notification_add),
            onRetry: onClosed
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (_) {
          context.read<SettingsViewModel>().resultState = ResultState.started;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(TextStrings.editAuthenticationScreen_4(type), style: const TextStyle(color: onPrimaryColor)),
              backgroundColor: primaryColor,
              foregroundColor: backgroundColor,
            ),
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
                                    Text(TextStrings.editAuthenticationScreen_1(type),textAlign: TextAlign.center,style: petrolabTextTheme.titleMedium,),
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
                                          focusedErrorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue, width: 2),
                                          ),
                                          errorBorder: UnderlineInputBorder(
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
                                          hintText: (args) ? TextStrings.editAuthenticationScreen_3 : TextStrings.editAuthenticationScreen_2,
                                          icon: (args) ? const Icon(Icons.lock) : const Icon(Icons.email),
                                          isPassword: args,
                                          validator: (val) {
                                            if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                            if (args) {
                                              if (!val.isValidPassword) return TextStrings.invalidPasswordWarning;
                                            } else {
                                              if (!val.isValidEmail) return TextStrings.invalidEmailWarning;
                                            }
                                            return null;
                                          },
                                          onSubmited: (value){
                                            (args) ? viewmodel.setNewPassword = value : viewmodel.setNewEmail = value;
                                          },
                                          textfieldController: null
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if(_formKey.currentState!.validate()) {
                                              (args) ? await viewmodel.changePassword() : await viewmodel.verifyEmail();
                                              if (viewmodel.state == ResultState.error) {
                                               if(mounted) {
                                                 _showAlertDialog(context, TextStrings.editAuthenticationScreen_7, TextStrings.alertButton_1,() {
                                                 viewmodel.resultState = ResultState.started;
                                                 Navigator.of(context).pop();
                                               });
                                               }
                                              }
                                              else {
                                                if(mounted) {
                                                  _showAlertDialog(context, (args) ? TextStrings.editAuthenticationScreen_5 : TextStrings.editAuthenticationScreen_6(viewmodel.newEmail!), TextStrings.alertButton_1,() {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                });
                                                }
                                              }
                                            }
                                          },
                                          child: const Text(TextStrings.editAuthenticationScreen_8,style: TextStyle(color: onPrimaryColor)),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            backgroundColor: primaryColor,
                                          ),
                                        )
                                    )
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