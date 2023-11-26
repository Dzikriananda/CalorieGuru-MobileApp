import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/profile_screen/widgets/profile_alert_dialog.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/profile_screen/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var args;
  late UserModel user;
  late String email;
  bool isEnabled = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController activityLevelController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController calorieNeedController = TextEditingController();



  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    user = args['userModel'];
    email = args['email'];
    setTextFieldController(context);
    super.didChangeDependencies();

  }

  void setTextFieldController(BuildContext context){
    genderController.text = (Provider.of<SettingsViewModel>(context,listen: false).user.gender!) ? 'Female' : 'Male';
    activityLevelController.text = (Provider.of<SettingsViewModel>(context,listen: true).activityLevel);
    nameController.text = (Provider.of<SettingsViewModel>(context,listen: true).user.name!);
    heightController.text = (Provider.of<SettingsViewModel>(context,listen: true).user.height.toString());
    weightController.text = (Provider.of<SettingsViewModel>(context,listen: true).user.weight.toString());

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


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile', style: TextStyle(color: onPrimaryColor)),
          backgroundColor: primaryColor,
        ),
        body: SafeArea(
          child: Consumer<SettingsViewModel>(
              builder: (context,viewmodel,child) {
                return SingleChildScrollView(
                  child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.4,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(0.0),
                                      bottomRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(0.0),
                                      bottomLeft: Radius.circular(30.0)),
                                  color: primaryContainer
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(60), // Image radius
                                      child: Image.network('https://www.w3schools.com/howto/img_avatar.png', fit: BoxFit.cover),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Text((viewmodel.email != null) ? viewmodel.email! : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                                  // SizedBox(height: 10),
                                  ProfileItem(
                                      item: CustomFormField(
                                        style: profileScreenTextStyle,
                                        readOnly: false,
                                        onTap: () {},
                                        suffixIcon: null,
                                        margin: 1.0,
                                        hasUnderline: true,
                                        maxLines: 1,
                                        initialValue: null,
                                        backgroundColor: primaryContainer,
                                        isEnabled: isEnabled,
                                        hintText: "Name",
                                        icon: const Icon(Icons.person),
                                        isPassword: false,
                                        validator: (val) {
                                          if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                          if (!val.isValidWeight) return TextStrings.invalidWeightWarning;
                                          return null;

                                        },
                                        onSubmited: (value){
                                          // viewmodel.user.name = value;

                                        },
                                        textfieldController: nameController,
                                      ),
                                  ),
                                  ProfileItem(
                                    item: CustomFormField(
                                      style: profileScreenTextStyle,
                                      readOnly: true,
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => ProfileAlertDialog(type: 'Gender',onOk: (){

                                          })
                                        );
                                      },
                                      suffixIcon: const Icon(Icons.arrow_drop_down_sharp,size: 35,),
                                      margin: 1.0,
                                      hasUnderline: true,
                                      maxLines: 1,
                                      initialValue: null,
                                      backgroundColor: primaryContainer,
                                      isEnabled: isEnabled,
                                      hintText: "Gender",
                                      icon: Icon((viewmodel.user.gender!) ? Icons.female_outlined : Icons.male_outlined),
                                      isPassword: false,
                                      validator: (val) {
                                        if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                        if (!val.isValidWeight) return TextStrings.invalidWeightWarning;
                                        return null;

                                      },
                                      onSubmited: (value){
                                      },
                                      textfieldController: genderController,
                                    ),
                                  ),
                                  ProfileItem(
                                    item: CustomFormField(
                                      style: profileScreenTextStyle,
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(), //get today's date
                                            firstDate:DateTime.now().subtract(const Duration(days: 29218)), //DateTime.now() - 80 Years.
                                            lastDate: DateTime.now()
                                        );
                                      },
                                      suffixIcon: null,
                                      margin: 1.0,
                                      hasUnderline: true,
                                      maxLines: 1,
                                      initialValue: DateFormat('yMMMMd').format(DateTime.parse(viewmodel.user.birthdate!)),
                                      backgroundColor: primaryContainer,
                                      isEnabled: isEnabled,
                                      hintText: "Birthdate",
                                      icon: const Icon(Icons.date_range_outlined),
                                      isPassword: false,
                                      validator: (val) {
                                        if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                        if (!val.isValidWeight) return TextStrings.invalidWeightWarning;
                                        return null;

                                      },
                                      onSubmited: (value){

                                      },
                                    ),
                                  ),
                                  ProfileItem(
                                    item: CustomFormField(
                                      style: profileScreenTextStyle,
                                      readOnly: false,
                                      onTap: () {},
                                      suffixIcon: null,
                                      margin: 1.0,
                                      hasUnderline: true,
                                      maxLines: 1,
                                      initialValue: null,
                                      backgroundColor: primaryContainer,
                                      isEnabled: isEnabled,
                                      hintText: "Weight",
                                      icon: const Icon(Icons.monitor_weight),
                                      isPassword: false,
                                      validator: (val) {
                                        if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                        if (!val.isValidWeight) return TextStrings.invalidWeightWarning;
                                        return null;
                                      },
                                      onSubmited: (value){
                                      },
                                      textfieldController: weightController,
                                    ),
                                  ),
                                  ProfileItem(
                                    item: CustomFormField(
                                      style: profileScreenTextStyle,
                                      readOnly: false,
                                      onTap: () {},
                                      suffixIcon: null,
                                      margin: 1.0,
                                      hasUnderline: true,
                                      maxLines: 1,
                                      initialValue: null,
                                      backgroundColor: primaryContainer,
                                      isEnabled: isEnabled,
                                      hintText: "Height",
                                      icon: const Icon(Icons.height,color: Colors.black),
                                      isPassword: false,
                                      validator: (val) {
                                        if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                        if (!val.isValidWeight) return TextStrings.invalidWeightWarning;
                                        return null;

                                      },
                                      onSubmited: (value){
                                      },
                                      textfieldController: heightController,
                                    ),
                                  ),
                                  ProfileItem(
                                    item: CustomFormField(
                                      style: profileScreenTextStyle,
                                      readOnly: false,
                                      onTap: () {},
                                      suffixIcon: null,
                                      margin: 1.0,
                                      hasUnderline: true,
                                      maxLines: 1,
                                      initialValue: '${viewmodel.user.calorieNeed.toString()} Kcal',
                                      backgroundColor: primaryContainer,
                                      isEnabled: isEnabled,
                                      hintText: "Calorie Need / Day",
                                      icon: const Icon(Icons.fastfood),
                                      isPassword: false,
                                      validator: (val) {
                                        if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                        if (!val.isValidWeight) return TextStrings.invalidWeightWarning;
                                        return null;

                                      },
                                      onSubmited: (value){

                                      },
                                    ),
                                  ),
                                  ProfileItem(
                                    item: CustomFormField(
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
                                      backgroundColor: primaryContainer,
                                      isEnabled: isEnabled,
                                      hintText: "Activity Level",
                                      icon: const Icon(Icons.sports_martial_arts_sharp),
                                      isPassword: false,
                                      validator: (val) {
                                        if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                        if (!val.isValidWeight) return TextStrings.invalidWeightWarning;
                                        return null;

                                      },
                                      onSubmited: (value){

                                      },
                                      textfieldController: activityLevelController,
                                    ),
                                  ),


                                  Visibility(
                                    visible: isEnabled,
                                    child: const SizedBox(height: 20),
                                  )
                                ],
                              ),

                            ),
                          ),

                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEnabled = !isEnabled;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: onPrimaryColor,
                              minimumSize: const Size(88, 36),
                              padding: const EdgeInsets.symmetric(horizontal: 150),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            child: const Text('Edit Profile',textAlign: TextAlign.center,),
                          ),

                        ],
                      )
                  ),

                );
              }
          ),
        )
    );
  }
}




