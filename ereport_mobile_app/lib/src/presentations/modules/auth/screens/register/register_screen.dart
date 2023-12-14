import 'package:ereport_mobile_app/src/core/constants/global_list.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
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

  List<String> appBarTitle = GlobalList.appBarTitle;

  void _showAlertDialog(BuildContext context,Function retry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
            content: TextStrings.alertContent_1,
            buttonText: TextStrings.alertButton_2,
            icon: const Icon(Icons.warning),
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
      const SecondRegisterWidget(),
      const ThirdRegisterWidget(),
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
            viewmodel.disposeViewModel();
            WidgetsBinding.instance.addPostFrameCallback((_) {
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
                          const Expanded(child: SizedBox()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              viewmodel.page == 0 ? const Icon(Icons.circle,size: 20) : const Icon(Icons.circle_outlined,size: 20),
                              viewmodel.page == 1 ? const Icon(Icons.circle,size: 20) : const Icon(Icons.circle_outlined,size: 20),
                              viewmodel.page == 2 ? const Icon(Icons.circle,size: 20) : const Icon(Icons.circle_outlined,size: 20),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor,
                                  side: const BorderSide(
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
                                child: const Text(TextStrings.registerParentScreen_1,style: TextStyle(color: onPrimaryContainer)),
                              ),
                              Hero(
                                tag: "next",
                                child: ElevatedButton(
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
                                            viewmodel.nextPage();
                                          }
                                        }
                                        break;
                                      case 1:
                                        {
                                          viewmodel.checkVisibilitySecondPage();
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
                                  child: const Text(TextStrings.registerParentScreen_2,style: TextStyle(color: onPrimaryColor)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.13)
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