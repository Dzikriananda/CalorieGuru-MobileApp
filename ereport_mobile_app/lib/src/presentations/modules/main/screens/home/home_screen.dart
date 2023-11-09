import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ereport_mobile_app/src/core/classes/icons.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/auth/firestore.dart';
import 'package:ereport_mobile_app/src/data/data_source/local/icon_data.dart';
import 'package:ereport_mobile_app/src/data/models/list_log_model.dart';
import 'package:ereport_mobile_app/src/data/models/user.dart';
import 'package:ereport_mobile_app/src/data/models/user_model.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/home_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/global_widgets/alert_dialog.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/custom_container.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/grid_view_builder.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/list_view_builder.dart';
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


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      context.read<HomeViewModel>().checkNetwork();
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().getListLog();
      context.read<HomeViewModel>().getUserData();
      context.read<HomeViewModel>().getTodayCalorie();
      context.read<HomeViewModel>().checkNetwork();
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
    var status = context.watch<HomeViewModel>().state;
    if(status == ResultState.noConnection){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bool isShow = _isThereCurrentDialogShowing(context);
        if(!isShow){
          _showAlertDialog(context);
        }
      });
    }
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
            systemNavigationBarColor: primaryColor
        ),
        child: Scaffold(
            body: SafeArea(
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
                                                    Icon(Icons.date_range),
                                                    SizedBox(width: 5),
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
                                          percent: (appUser != null && viewmodel.consumedCalories != null) ? (viewmodel.consumedCalories! / appUser.calorieNeed!) : 0,
                                          center: Text((appUser == null)? TextStrings.loadingText : '${viewmodel.caloriesLeft} Kcal left',style: homeScreenReportText4,),
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
                                                      Text('${(viewmodel.consumedCalories != null)? viewmodel.consumedCalories!.round() : 0} Kcal',style: homeScreenReportText5),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Icon(Icons.local_fire_department,size: 50,color: Colors.red,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Burned',style: homeScreenReportText3),
                                                      Text('150 Kcal',style: homeScreenReportText6),
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
                            SizedBox(height: 15),
                            SizedBox(
                                height: 120,
                                child: GridViewBuilder(
                                  icons: reportIcon,
                                  onTapped: () {
                                    viewmodel.refreshData();
                                  },
                                )
                            ),
                            Align(
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
                                  ...viewmodel.listLog.map((e) => recentItem(content: e) ).toList(),
                                ],
                              )

                            ),
                            SizedBox(height: 20)
                          ],
                        ),
                      ),
                      Visibility(
                        visible: (status == ResultState.loading),
                        child: const CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      )
                    ],
                  );
                },
              )
            )
        ),
    );
  }
}

class recentItem extends StatelessWidget {
  ListLogModel content;

  recentItem({Key? key,required this.content}) : super(key: key);


  @override
  Widget build(BuildContext context) {
      return Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((content != null)? "Meal - ${content.instanceType!}" : '',style: listActivityText,textAlign: TextAlign.start),
                          Text((content != null)? "${content.instanceName!} " : '',style: listActivityText2),
                        ],
                      ),
                    )
                  ),
                  Text('(+ ${content.calories} Kcal) ',style: listActivityText2),
                  // Icon(Icons.fastfood_sharp,size: 40),

                ],
              ),
          ),
      );
  }
}



// (viewmodel.listLog.length == 0)? Center(child: Text('No Activity Yet!',style: emptyActivityText))
//     : Column(
// children: [
// ...viewmodel.listLog.map((e) => recentItem(content: '${e.instanceType} - ${e.instanceName} ( + ${e.calories} Kcal)') ).toList(),
// ],
// )





