import 'dart:ui';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/register_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/global_widgets/alert_dialog.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/widgets/first_register_widget.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/widgets/second_register_page.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/widgets/third_register_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef MyBuilder = void Function(BuildContext context, bool Function() methodFromChild);


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool Function() onNext;

  late List<Widget> page;

  List<String> appBarTitle = [
    "Your Personal Details",
    "Activity",
    "Your Result"
  ];

  void _showAlertDialog(BuildContext context,Function retry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            onRetry: (){
              retry();
              Navigator.of(context).pop();
            }
        );
      },
    );
  }

  bool _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;


  @override
  void initState(){
    super.initState();
    page = [
      FirstRegisterWidget(
      builder:
          (BuildContext context, bool Function() methodFromChild) {
        onNext = methodFromChild;
      },
    ),
      SecondRegisterWidget(),
      ThirdRegisterWidget(),
    ];
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
        builder: (context,viewmodel,child){
          var currentPage = viewmodel.page;

          if(viewmodel.state == ResultState.error){
            void retry = (viewmodel.response == null) ? viewmodel.getCalorieNeed() : viewmodel.updateData();
            bool isShow = _isThereCurrentDialogShowing(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if(!isShow) _showAlertDialog(context, () => retry);
            });
          }
          else if(viewmodel.state == ResultState.addDataSuccess){
            viewmodel.dispose();
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.of(context).pushNamedAndRemoveUntil('/bottomNavigation', (Route route) => false);
            });
          }

          return Scaffold(
              appBar: AppBar(
                title: Text(appBarTitle[currentPage],textAlign: TextAlign.center),
                automaticallyImplyLeading: false,
                elevation: 2.0,
                centerTitle: true,
              ),
              backgroundColor: backgroundColor,
              body: SingleChildScrollView(
                child: SafeArea(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          page[currentPage],
                          Expanded(child: SizedBox()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              viewmodel.page == 0 ? Icon(Icons.circle,size: 20) : Icon(Icons.circle_outlined,size: 20),
                              viewmodel.page == 1 ? Icon(Icons.circle,size: 20) : Icon(Icons.circle_outlined,size: 20),
                              viewmodel.page == 2 ? Icon(Icons.circle,size: 20) : Icon(Icons.circle_outlined,size: 20),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                child: Text("Previous",style: TextStyle(color: onPrimaryContainer)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor,
                                  side: BorderSide(
                                    width: 1.0,
                                    color: primaryColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  if(currentPage == 0){
                                    Navigator.of(context).pop();
                                  }
                                  else{
                                    viewmodel.previousPage();
                                  }
                                },
                              ),
                              Hero(
                                tag: "next",
                                child: ElevatedButton(
                                  child: Text("  Next  ",style: TextStyle(color: onPrimaryColor)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () async {
                                    switch(currentPage){
                                      case 0:
                                        {
                                          var isValid = onNext.call();
                                          if(isValid) {
                                            print(currentPage);
                                            viewmodel.nextPage();
                                          }
                                        }
                                        break;
                                      case 1:
                                        {
                                          if (viewmodel.activityLevel != null) {
                                              viewmodel.getCalorieNeed();
                                              viewmodel.nextPage();
                                          }
                                        }
                                        break;
                                      case 2:
                                        viewmodel.updateData();
                                        break;
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.13,)
                        ],
                      ),
                    )
                ),
              )
          );
        }
    );
  }
}