import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/system_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../../../data/viewmodel/home_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  late SystemViewModel systemViewModel;
  late SettingsViewModel settingsViewModel;

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<SettingsViewModel>(context, listen: false).init();
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    systemViewModel = Provider.of<SystemViewModel>(context,listen: true);
    settingsViewModel = Provider.of<SettingsViewModel>(context, listen: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      systemViewModel.mainBottomNavColor();
    });
    if(settingsViewModel.state == ResultState.unLogged) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        settingsViewModel.disposeViewModel();
        context.read<HomeViewModel>().disposeViewModel();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/authScreen', (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
    super.didChangeDependencies();
  }


  final snackBar = SnackBar(
    content: const Text(TextStrings.alertTitle_2),
    backgroundColor: primaryColor,
    duration: const Duration(seconds: 6),
    shape: const RoundedRectangleBorder(
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
    return SafeArea(
      child: Consumer<SettingsViewModel>(
          builder: (context,viewmodel,child) {
            return Center(
                child: Column(
                  children: [
                    Container(
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
                              child: Image.network(DefaultImages.avatar_1, fit: BoxFit.cover),
                            ),
                          ),
                          Text((viewmodel.user.name != null) ? viewmodel.user.name! : TextStrings.loadingText,style: settingsScreen1,),
                          Text((viewmodel.email != null) ? viewmodel.email! : TextStrings.loadingText,style: petrolabTextTheme.titleSmall),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    SettingsItem(
                        title: TextStrings.settingsScreen_1,
                        icon: Icons.person,
                        onPressed: () {
                          systemViewModel.lightBottomNavColor();
                          Navigator.pushNamed(context, '/profileScreen',arguments: {'userModel' : viewmodel.user,'email':viewmodel.email});
                        },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: TextStrings.settingsScreen_2,
                      icon: Icons.logout,
                      onPressed: (){
                        systemViewModel.lightBottomNavColor();
                        viewmodel.logOut();
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: TextStrings.settingsScreen_3,
                      icon: Icons.delete,
                      onPressed: (){
                        systemViewModel.lightBottomNavColor();
                        Navigator.pushNamed(context, '/enterAuthenticationScreen',arguments: true);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: TextStrings.settingsScreen_4,
                      icon: Icons.supervised_user_circle,
                      onPressed: (){
                        systemViewModel.lightBottomNavColor();
                        Navigator.pushNamed(context, '/aboutAppScreen');
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: TextStrings.settingsScreen_5,
                      icon: Icons.admin_panel_settings_sharp,
                      onPressed: (){
                        systemViewModel.lightBottomNavColor();
                        Navigator.pushNamed(context, '/enterAuthenticationScreen',arguments: false);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: TextStrings.settingsScreen_6,
                      icon: Icons.help,
                      onPressed: (){
                        systemViewModel.lightBottomNavColor();
                        Navigator.pushNamed(context, '/faqScreen');
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SettingsItem(
                      title: TextStrings.settingsScreen_7,
                      icon: Icons.help_center,
                      onPressed: (){
                        systemViewModel.lightBottomNavColor();
                        Navigator.pushNamed(context, '/feedbackScreen');
                      },
                    ),
                  ],
                )
            );
          }
      ),
    );
  }
}




