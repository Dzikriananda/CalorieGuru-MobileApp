import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/system_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/widgets/settings_item.dart';
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

  late SystemViewModel systemViewModel;

  @override
  void initState(){
    super.initState();
    final stat_awal = Provider.of<SettingsViewModel>(context, listen: false).state;
    print("state saat init : $stat_awal");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<SettingsViewModel>(context, listen: false).init();
    });
  }

  @override
  void didChangeDependencies() {
    systemViewModel = Provider.of<SystemViewModel>(context,listen: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      systemViewModel.mainBottomNavColor();
    });
    super.didChangeDependencies();
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
    return SafeArea(
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    SettingsItem(
                        title: 'Profile',
                        icon: Icons.person,
                        onPressed: () {
                          systemViewModel.lightBottomNavColor();
                          Navigator.pushNamed(context, '/profileScreen',arguments: {'userModel' : viewmodel.user,'email':viewmodel.email});
                        },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: 'Logout',
                      icon: Icons.logout,
                      onPressed: (){
                        viewmodel.logOut();
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: 'Delete Account',
                      icon: Icons.delete,
                      onPressed: (){},
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: 'About App',
                      icon: Icons.supervised_user_circle,
                      onPressed: (){},
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: 'Change Email / Password',
                      icon: Icons.admin_panel_settings_sharp,
                      onPressed: (){},
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: 'Help/FeedBack',
                      icon: Icons.help_center,
                      onPressed: (){},
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
    );
  }
}




