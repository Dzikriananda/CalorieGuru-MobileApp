import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/feedback_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/global_widgets/alert_dialog.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  final _formKey = GlobalKey<FormState>();

  Color color = Colors.black;

  void _showAlertDialog(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            content: message,
            buttonText: TextStrings.feedbackScreen_9,
            icon:  Icon(Icons.warning),
            onRetry: (){
              Navigator.of(context).pop(); // Close the dialog./ Close the dialog.
            }
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          context.read<FeedBackViewModel>().disposeViewModel();
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(TextStrings.feedbackScreen_1),
              backgroundColor: primaryColor,
              foregroundColor: onPrimaryColor,
            ),
            body: Consumer<FeedBackViewModel>(
                builder: (context,viewmodel,child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.2,
                                color: primaryContainer,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(TextStrings.feedbackScreen_2, style: feedBackScreen_1),
                                    SizedBox(height: 10),
                                    Text(TextStrings.feedbackScreen_3, style: feedBackScreen_2),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(TextStrings.feedbackScreen_4, style: feedBackScreen_1),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () => viewmodel.pressed = 1 ,
                                            child: SvgPicture.asset(DefaultImages.emoji_1,height: 30, colorFilter: ColorFilter.mode(viewmodel.getColor(1), BlendMode.srcIn)),
                                          ),
                                          InkWell(
                                            onTap: () => viewmodel.pressed = 2,
                                            child: SvgPicture.asset(DefaultImages.emoji_2,height: 30, colorFilter: ColorFilter.mode(viewmodel.getColor(2), BlendMode.srcIn)),
                                          ),
                                          InkWell(
                                            onTap: () => viewmodel.pressed = 3,
                                            child: SvgPicture.asset(DefaultImages.emoji_3,height: 30, colorFilter: ColorFilter.mode(viewmodel.getColor(3), BlendMode.srcIn)),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                              Visibility(
                                  visible: (viewmodel.isOptionEmpty),
                                  child: Text(TextStrings.feedbackScreen_11,style: chooseItemTextError)
                              ),
                              const SizedBox(height: 15),
                              Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height * 0.35,
                                  color: borderColor_3,
                                  child: Form(
                                    key: _formKey,
                                    child: CustomFormField(
                                      style: profileScreenTextStyle,
                                      readOnly: false,
                                      onTap: () {},
                                      suffixIcon: null,
                                      margin: 1.0,
                                      hasUnderline: false,
                                      maxLines: 50,
                                      initialValue: null,
                                      backgroundColor: Color(0XFFE5E5E5),
                                      isEnabled: true,
                                      hintText: TextStrings.feedbackScreen_6,
                                      icon: null,
                                      isPassword: false,
                                      validator: (val) {
                                        if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                        return null;
                                      },
                                      onSubmited: (value){
                                        viewmodel.feedback = value;
                                      },
                                      textfieldController: null,
                                    ),
                                  )
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_formKey.currentState!.validate()) {
                                      await viewmodel.sendFeedback();
                                      if(viewmodel.state == ResultState.success) {
                                        _showAlertDialog(context,viewmodel.message!);
                                        viewmodel.disposeViewModel();
                                      }
                                      else if (viewmodel.state == ResultState.error){
                                        _showAlertDialog(context,viewmodel.message!);
                                      }
                                      else;
                                    }
                                  },
                                  child: Text(TextStrings.feedbackScreen_7,style: LoginButtonText),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
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
    );
  }
}