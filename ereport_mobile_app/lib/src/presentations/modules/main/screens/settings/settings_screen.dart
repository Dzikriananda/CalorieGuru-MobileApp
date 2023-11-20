import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../../data/viewmodel/home_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState(){
    super.initState();
    final stat_awal = Provider.of<SettingsViewModel>(context, listen: false).state;
    print("state saat init : $stat_awal");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<SettingsViewModel>(context, listen: false).init();
    });
  }

  final snackBar = SnackBar(
    content: const Text('Notification'),
    backgroundColor: primaryColor,
    duration: const Duration(seconds: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          ),
    ),
    action: SnackBarAction(
      label: TextStrings.loggedOutText,
      textColor: onPrimaryColor,
      onPressed: () {},
    ),
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsViewModel>(context, listen: true);
    if(provider.state == ResultState.unLogged) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        provider.dispose();
        context.read<HomeViewModel>().disposeViewModel();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/authScreen', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.grey,
          systemNavigationBarColor: primaryColor
      ),
      child: Scaffold(
          body: SafeArea(
            child: Consumer<SettingsViewModel>(
                builder: (context,viewmodel,child) {
                  return Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0,0,0,0
                            ),
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
                                  Text((viewmodel.user.name != null) ? viewmodel.user.name! : TextStrings.loadingText,style: settingsScreen1,),
                                  Text((viewmodel.email != null) ? viewmodel.email! : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                                  SizedBox(height: 15),
                                ],
                              ),


                            ),

                          ),
                          SizedBox(height: 50),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Icon(Icons.person,size: 40),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text('Profile',style: petrolabTextTheme.titleLarge,),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, '/profileScreen',arguments: {'userModel' : viewmodel.user,'email':viewmodel.email});
                                    },
                                    icon: Icon(Icons.arrow_forward_ios)
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Icon(Icons.logout,size: 40),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text('Logout',style: petrolabTextTheme.titleLarge,),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconButton(
                                    onPressed: (){
                                      viewmodel.logOut();
                                    },
                                    icon: Icon(Icons.arrow_forward_ios)
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Icon(Icons.delete,size: 40),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text('Delete Account',style: petrolabTextTheme.titleLarge,),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.arrow_forward_ios)
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Icon(Icons.account_box_outlined,size: 40),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text('About Me',style: petrolabTextTheme.titleLarge,),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.arrow_forward_ios)
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Icon(Icons.help_center,size: 40),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text('Help/FeedBack',style: petrolabTextTheme.titleLarge,),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.arrow_forward_ios)
                                )
                              ],
                            ),
                          ),
                          // SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: primaryColor,
                          //     foregroundColor: onPrimaryColor,
                          //     minimumSize: Size(88, 36),
                          //     padding: EdgeInsets.symmetric(horizontal: 150),
                          //     shape: const RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.all(Radius.circular(12)),
                          //     ),
                          //   ),
                          //   child: const Text('Edit Profile',textAlign: TextAlign.center,),
                          // ),
                          // ElevatedButton(
                          //   onPressed: () => viewmodel.logOut(),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: primaryColor,
                          //     foregroundColor: onPrimaryColor,
                          //     minimumSize: Size(88, 36),
                          //     padding: EdgeInsets.symmetric(horizontal: 167),
                          //     shape: const RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.all(Radius.circular(12)),
                          //     ),
                          //   ),
                          //   child: const Text('Logout',textAlign: TextAlign.center),
                          // ),

                        ],
                      )
                  );
                }
            ),
          )
      )
    );
  }
}




