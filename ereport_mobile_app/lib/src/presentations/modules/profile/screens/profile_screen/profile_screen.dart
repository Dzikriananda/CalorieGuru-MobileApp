
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../../data/viewmodel/home_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final args;
  late final UserModel user;
  late final String email;

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    user = args['userModel'];
    email = args['email'];
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: TextStyle(color: onPrimaryColor)),
          backgroundColor: primaryColor,
        ),
        body: SafeArea(
          child: Consumer<SettingsViewModel>(
              builder: (context,viewmodel,child) {
                return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: Container(
                            // height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(0.0),
                                    bottomRight: Radius.circular(30.0),
                                    topLeft: Radius.circular(0.0),
                                    bottomLeft: Radius.circular(30.0)),
                                color: primaryContainer
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(60), // Image radius
                                    child: Image.network('https://www.w3schools.com/howto/img_avatar.png', fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Text((viewmodel.email != null) ? viewmodel.email! : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(Icons.people_sharp),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Name', style: profileScreen1,textAlign: TextAlign.left,),
                                        Text((viewmodel.user.name != null) ? viewmodel.user.name! : TextStrings.loadingText,style: petrolabTextTheme.titleSmall,),
                                        
                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(Icons.people_sharp),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Gender', style: profileScreen1,textAlign: TextAlign.left,),
                                        Text((viewmodel.user.gender != null) ? viewmodel.user.gender.toString() : TextStrings.loadingText,style: petrolabTextTheme.titleSmall,),
                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(Icons.email),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Email', style: profileScreen1,textAlign: TextAlign.left,),
                                        Text((viewmodel.email != null) ? viewmodel.email! : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),

                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(Icons.date_range_outlined),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Birthdate', style: profileScreen1,textAlign: TextAlign.left,),
                                        Text((viewmodel.user.birthdate != null) ? viewmodel.user.birthdate! : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(Icons.sports_martial_arts_sharp),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Activity Level', style: profileScreen1,textAlign: TextAlign.left,),
                                        SizedBox(
                                          width: 300,
                                          child:Text((viewmodel.user.activityLevel != null) ? viewmodel.user.activityLevel! : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                                        )
                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(Icons.monitor_weight),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Weight', style: profileScreen1,textAlign: TextAlign.left,),
                                        SizedBox(
                                          width: 300,
                                          child:Text((viewmodel.user.weight != null) ? '${viewmodel.user.weight} Kg' : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                                        )
                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(Icons.height),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Height', style: profileScreen1,textAlign: TextAlign.left,),
                                        SizedBox(
                                          width: 300,
                                          child:Text((viewmodel.user.height != null) ? '${viewmodel.user.height} Cm' : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                                        )
                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Icon(Icons.fastfood),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Calorie Need', style: profileScreen1,textAlign: TextAlign.left,),
                                        SizedBox(
                                          width: 300,
                                          child:Text((viewmodel.user.calorieNeed != null) ? '${viewmodel.user.calorieNeed} Cal' : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                                        )
                                      ],
                                    )

                                  ],
                                ),
                                SizedBox(height: 40),

                              ],
                            ),

                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: onPrimaryColor,
                            minimumSize: Size(88, 36),
                            padding: EdgeInsets.symmetric(horizontal: 150),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          child: const Text('Edit Profile',textAlign: TextAlign.center,),
                        ),
                      ],
                    )
                );
              }
          ),
        )
    );
  }
}




