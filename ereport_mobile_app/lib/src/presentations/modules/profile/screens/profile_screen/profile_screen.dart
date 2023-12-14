import 'dart:math';

import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/profile_screen/widgets/profile_alert_dialog.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/profile_screen/widgets/profile_container.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/profile_screen/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/result_state.dart';
import '../../../../global_widgets/alert_dialog.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var args;
  late UserModel user;
  late String email;
  late SettingsViewModel viewModel;
  bool isEnabled = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController activityLevelController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController calorieNeedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  



  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<SettingsViewModel>(context,listen: true);
    args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    user = args['userModel'];
    email = args['email'];
    setTextFieldController(context);
    super.didChangeDependencies();

  }

  void setTextFieldController(BuildContext context){
    genderController.text = viewModel.temporaryGender! ? 'Female' : 'Male';
    activityLevelController.text = viewModel.tempActivityLevel;
    nameController.text = viewModel.user.name!;
    heightController.text = viewModel.user.height.toString();
    weightController.text = viewModel.user.weight.toString();
    calenderController.text = DateFormat('yMMMMd').format(viewModel.tempDate);
    calorieNeedController.text = viewModel.user.calorieNeed.toString();


  }

  @override
  void dispose(){
    genderController.dispose();
    nameController.dispose();
    activityLevelController.dispose();
    calenderController.dispose();
    heightController.dispose();
    weightController.dispose();
    calorieNeedController.dispose();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            content: "Update is Failed!",
            buttonText: "OK",
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
    return Scaffold(
        appBar: AppBar(
          title: Text( (isEnabled) ? 'Edit Profile' : 'Profile', style: TextStyle(color: onPrimaryContainer)),
          backgroundColor: primaryContainer,
          foregroundColor: onPrimaryContainer,
        ),
        body: SafeArea(
          child: Consumer<SettingsViewModel>(
              builder: (context,viewmodel,child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Center(
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    ProfileContainer(progress: 0.5),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          ProfileItem(
                                            item: CustomFormField(
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
                                              ),                                              style: profileScreenTextStyle,
                                              readOnly: false,
                                              onTap: () {},
                                              suffixIcon: null,
                                              margin: 1.0,
                                              hasUnderline: true,
                                              maxLines: 1,
                                              initialValue: null,
                                              backgroundColor: backgroundColor,
                                              isEnabled: isEnabled,
                                              hintText: "Name",
                                              icon: const Icon(Icons.person),
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                                return null;
                                              },
                                              onSubmited: (_){},
                                              textfieldController: nameController,
                                            ),
                                          ),
                                          ProfileItem(
                                            item: CustomFormField(
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
                                              readOnly: true,
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) => ProfileAlertDialog(type: 'Gender',onOk: (){})
                                                );
                                              },
                                              suffixIcon: const Icon(Icons.arrow_drop_down_sharp,size: 35,),
                                              margin: 1.0,
                                              hasUnderline: true,
                                              maxLines: 1,
                                              initialValue: null,
                                              backgroundColor: backgroundColor,
                                              isEnabled: isEnabled,
                                              hintText: "Gender",
                                              icon: Icon((viewmodel.temporaryGender!) ? Icons.female_outlined : Icons.male_outlined),
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                                return null;

                                              },
                                              onSubmited: (_){},
                                              textfieldController: genderController,
                                            ),
                                          ),
                                          ProfileItem(
                                            item: CustomFormField(
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
                                              readOnly: true,
                                              onTap: () async {
                                                DateTime? pickedDate = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(), //get today's date
                                                    firstDate:DateTime.now().subtract(const Duration(days: 29218)), //DateTime.now() - 80 Years.
                                                    lastDate: DateTime.now()
                                                );
                                                if(pickedDate != null) {
                                                  viewModel.tempDate = pickedDate;
                                                }
                                              },
                                              suffixIcon: null,
                                              margin: 1.0,
                                              hasUnderline: true,
                                              maxLines: 1,
                                              initialValue: null,
                                              backgroundColor: backgroundColor,
                                              isEnabled: isEnabled,
                                              hintText: "Birthdate",
                                              icon: const Icon(Icons.date_range_outlined),
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                                return null;
                                              },
                                              onSubmited: (_){},
                                              textfieldController: calenderController,
                                            ),
                                          ),
                                          ProfileItem(
                                            item: CustomFormField(
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
                                              isEnabled: isEnabled,
                                              hintText: "Weight",
                                              icon: const Icon(Icons.monitor_weight),
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                                if (!val!.isValidWeight) return TextStrings.invalidWeightWarning;
                                                return null;
                                              },
                                              onSubmited: (_){},
                                              textfieldController: weightController,
                                            ),
                                          ),
                                          ProfileItem(
                                            item: CustomFormField(
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
                                              isEnabled: isEnabled,
                                              hintText: "Height",
                                              icon: const Icon(Icons.height,color: Colors.black),
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                                if (!val!.isValidHeight) return TextStrings.invalidHeightlWarning;
                                                return null;
                                              },
                                              onSubmited: (_){},
                                              textfieldController: heightController,
                                            ),
                                          ),
                                          ProfileItem(
                                            item: CustomFormField(
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
                                              isEnabled: isEnabled,
                                              hintText: "Calorie Need / Day",
                                              icon: const Icon(Icons.fastfood),
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                                if (!val!.isValidCalorie) return TextStrings.invalidCalorieWarning;
                                                return null;
                                              },
                                              onSubmited: (_){},
                                              textfieldController: calorieNeedController,
                                            ),
                                          ),
                                          ProfileItem(
                                            item: CustomFormField(
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
                                              readOnly: true,
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) => ProfileAlertDialog(type: 'ActivityLevel',onOk: (){})
                                                );
                                              },
                                              suffixIcon: const Icon(Icons.arrow_drop_down_sharp,size: 35,),
                                              margin: 1.0,
                                              hasUnderline: true,
                                              maxLines: 1,
                                              initialValue: null,
                                              backgroundColor: backgroundColor,
                                              isEnabled: isEnabled,
                                              hintText: "Activity Level",
                                              icon: const Icon(Icons.sports_martial_arts_sharp),
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                                return null;
                                              },
                                              onSubmited: (_){},
                                              textfieldController: activityLevelController,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: isEnabled,
                                      child: const SizedBox(height: 20),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.height * 0.04,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isEnabled = !isEnabled;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    foregroundColor: onPrimaryColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                    ),
                                  ),
                                  child: Text((isEnabled) ? 'Cancel' : 'Edit Profile',textAlign: TextAlign.center,),
                                ),

                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: isEnabled,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if(_formKey.currentState!.validate()){
                                        final result = await viewModel.updateProfileData(
                                            nameController.text,
                                            weightController.text,
                                            heightController.text,
                                            calorieNeedController.text
                                        );
                                        if(result == true) {
                                          viewModel.disposeViewModel();
                                          Navigator.of(context).pop();
                                        }
                                        else{
                                          _showAlertDialog(context);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      foregroundColor: onPrimaryColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                      ),
                                    ),
                                    child: Text('Save',textAlign: TextAlign.center,),
                                  ),

                                ),
                              )
                            ],
                          )
                      ),

                    ),

                  ],
                );
              }
          ),
        )
    );
  }
}





