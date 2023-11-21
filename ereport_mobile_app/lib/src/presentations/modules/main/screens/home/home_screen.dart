import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ereport_mobile_app/src/core/classes/icons.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/screen_type.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore_repository.dart';
import 'package:ereport_mobile_app/src/data/data_source/local/icon_data.dart';
import 'package:ereport_mobile_app/src/data/models/list_log_model.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:ereport_mobile_app/src/data/models/user_model.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/home_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/system_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/global_widgets/alert_dialog.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/grid_view_builder.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/list_view_builder.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/recent_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:ereport_mobile_app/src/core/utils/StringExtension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  List<CustomIcon> reportIcon = icons;
  bool showAlert = false;
  late HomeViewModel homeViewModel;
  late SystemViewModel systemViewModel;


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      context.read<HomeViewModel>().checkNetwork();
      context.read<HomeViewModel>().refreshData();
    }
  }

  @override
  void didChangeDependencies() {
    homeViewModel = Provider.of<HomeViewModel>(context,listen: true);
    systemViewModel = Provider.of<SystemViewModel>(context,listen: true);
    if(homeViewModel.state == ResultState.noConnection){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bool isShow = _isThereCurrentDialogShowing(context);
        if(!isShow){
          _showAlertDialog(context);
        }
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      systemViewModel.mainBottomNavColor();
    });
    super.didChangeDependencies();
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      homeViewModel.getListLog();
      homeViewModel.getUserData();
      homeViewModel.getTodayCalorie();
      homeViewModel.checkNetwork();
    });
  }


  bool _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            onRetry: (){
              context.read<HomeViewModel>().checkNetwork();
              Navigator.of(context).pop(); // Close the dialog./ Close the dialog.
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<HomeViewModel>(
          builder: (context,viewmodel,child){
            UserModel? appUser = viewmodel.getUser;
            return Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child:  Container(
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(48), // Image radius
                                      child: Image.network('https://www.w3schools.com/howto/img_avatar.png', fit: BoxFit.cover),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery. of(context). size. width * 0.6,
                                          child: Text(
                                            appUser != null ? "Hi, ${appUser.name.toString().toCapitalized()}" : TextStrings.loadingText,
                                            style: petrolabTextTheme.titleLarge,
                                          ),
                                        ),
                                        Container(
                                            child: Row(
                                              children: [
                                                const Icon(Icons.date_range),
                                                const SizedBox(width: 5),
                                                Text(
                                                  viewmodel.todayDate,
                                                  style: petrolabTextTheme.titleMedium,
                                                ),
                                              ],
                                            )
                                        ),
                                      ]
                                  ),
                                ],
                              )
                          )
                      ),
                      const SizedBox(height: 10),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: primaryContainer,
                            borderRadius:  BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                  (appUser == null)? TextStrings.loadingText : 'Calorie Budget : ${appUser.calorieNeed!} Kcal',
                                  style: homeScreenReportText
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircularPercentIndicator(
                                    radius: 90.0,
                                    lineWidth: 16.0,
                                    percent: (appUser != null && viewmodel.caloriesLeft != null) ? ( (viewmodel.caloriesLeft!.toDouble().isNegative) ? 1 : (viewmodel.caloriesLeft! > appUser.calorieNeed!.toDouble()) ? 0 : ((appUser.calorieNeed! - viewmodel.caloriesLeft!) / appUser.calorieNeed!)) : 0,
                                    center: Text((viewmodel.caloriesLeft == null)? TextStrings.loadingText : '${viewmodel.caloriesLeft!.toStringAsFixed(1)} Kcal Left',style: homeScreenReportText4,),
                                    progressColor: primaryColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.food_bank_rounded,size: 50,color: Colors.blueAccent,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Eaten',style: homeScreenReportText2),
                                                Container(
                                                  child: Text('${(viewmodel.consumedCalories != null)? viewmodel.consumedCalories!: 0} Kcal',style: homeScreenReportText5),
                                                  constraints: const BoxConstraints(
                                                    minWidth: 50,
                                                    maxWidth: 80,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Icon(Icons.local_fire_department,size: 50,color: Colors.red,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Burned',style: homeScreenReportText3),
                                                Container(
                                                  child: Text('${(viewmodel.burnedCalories != null)? viewmodel.burnedCalories!: 0} Kcal',style: homeScreenReportText6),
                                                  constraints: const BoxConstraints(
                                                    minWidth: 50,
                                                    maxWidth: 80,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                          height: 120,
                          child: GridViewBuilder(
                            icons: reportIcon,
                            onTapped: () {
                              viewmodel.refreshData();
                            },
                            onNavigate: () {
                              systemViewModel.lightBottomNavColor();
                            },
                          )
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(22, 0, 0, 5),
                            child: Text(
                                "Recent Activities",
                                style: homeScreenReportText
                            ),
                          )
                      ),
                      Container(
                          height: (viewmodel.listLog.length < 3)? MediaQuery.of(context).size.width * 0.44 : null,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: primaryContainer,
                            borderRadius:  BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: (viewmodel.listLog.length == 0)? Center(child: Text('No Activity Yet!',style: emptyActivityText))
                              : Column(
                            children: [
                              ...viewmodel.listLog.map((e) => RecentItem(content: e,onTapped: () => viewmodel.refreshData(),touchable: true,onNavigate: () => systemViewModel.lightBottomNavColor() )).toList(),
                            ],
                          )

                      ),
                      const SizedBox(height: 20)
                    ],
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
          },
        )
    );
  }
}





// (viewmodel.listLog.length == 0)? Center(child: Text('No Activity Yet!',style: emptyActivityText))
//     : Column(
// children: [
// ...viewmodel.listLog.map((e) => recentItem(content: '${e.instanceType} - ${e.instanceName} ( + ${e.calories} Kcal)') ).toList(),
// ],
// )





