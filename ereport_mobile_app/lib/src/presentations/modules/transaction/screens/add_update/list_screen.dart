import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/add_update_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/data/data_source/remote/api_service.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/result_state.dart';
import '../../../../../core/constants/screen_type.dart';
import '../../../../../core/constants/text_strings.dart';
import '../../../../../data/auth/auth.dart';
import '../../../../../data/auth/firestore.dart';

class AddUpdateScreen extends StatefulWidget {

  AddUpdateScreen({Key? key}) : super(key: key);

  @override
  State<AddUpdateScreen> createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {

  final bool isUpdate = false;
  final bool isMeal = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  late String args;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    textField1Controller.dispose();
    textField2Controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as String;
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<AddUpdateViewModel>().setLogType(args);
    });
    super.didChangeDependencies();
  }

  void openDialog(BuildContext context,String title, String content){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Builder(
          builder: (context){
            return Container(
              child:  Text(
                content,
                style: petrolabTextTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: primaryColor,
                ),
                padding: const EdgeInsets.all(14),
                child: Icon(Icons.close,color: onPrimaryColor,)
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if ( context.read<AddUpdateViewModel>().state == ResultState.loading) return false;
          else {
            context.read<AddUpdateViewModel>().disposeViewModel();
            return true;
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(' Add $args', style: TextStyle(color: onPrimaryColor)),
              backgroundColor: primaryColor,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final viewmodel = context.read<AddUpdateViewModel>();
                  viewmodel.setInstanceName = textField1Controller.text;
                  viewmodel.setCalorie = textField2Controller.text;
                  viewmodel.checkChoice();
                  if (viewmodel.isValidChoice!) {
                    final result = await viewmodel.addLog();
                    if (result) {
                      viewmodel.disposeViewModel();
                      Navigator.of(context).pop(true);
                    }
                    else {
                      openDialog(context, TextStrings.addScreenFailedAddNotifName, TextStrings.addScreenFailedAddNotifContent);
                    }
                  }
                }
              },
              shape: CircleBorder(),
              foregroundColor: onPrimaryColor,
              backgroundColor: primaryColor,
              child: const Icon(Icons.check),
            ),
            body: Consumer<AddUpdateViewModel>(
              builder: (context,viewmodel,child){
                viewmodel.logType = args;
                textField2Controller.text = ((viewmodel.calorie != null )? viewmodel.calorie.toString() : '');
                textField1Controller.text = ((viewmodel.instanceName != null )? viewmodel.instanceName! : '');
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: primaryContainer,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.all(Radius.circular(15)),
                                  //   color: primaryContainer,
                                  // ),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            child: Text(
                                                (args == ScreenType.Meal.name)? TextStrings.addScreen_1 : TextStrings.addScreen_8,
                                                style: homeScreenReportText
                                            ),
                                          )
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            CustomFormField(
                                              hasUnderline: true,
                                              backgroundColor: primaryContainer,
                                              hintText: (args == ScreenType.Meal.name)? TextStrings.addScreen_textfield1_hinttext1 : TextStrings.addScreen_textfield1_hinttext2,
                                              icon: null,
                                              initialValue: null,
                                              isEnabled: true,
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                              },
                                              onSubmited: (value){

                                              },
                                              maxLines: 3,
                                              textfieldController: textField1Controller,
                                            ),
                                            CustomFormField(
                                              hasUnderline: true,
                                              backgroundColor: primaryContainer,
                                              hintText: (args == ScreenType.Meal.name)? TextStrings.addScreen_textfield2_hinttext1 : TextStrings.addScreen_textfield2_hinttext2,
                                              icon: null,
                                              initialValue: null,
                                              isEnabled: true,
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                                else if(!val.isValidCalorie) return TextStrings.invalidCalorieWarning;
                                              },
                                              onSubmited: (value){
                                              },
                                              maxLines: 1,
                                              textfieldController: textField2Controller,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(25, 0, 0, 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(TextStrings.addScreen_2,style: petrolabTextTheme.titleLarge,),
                                            SizedBox(
                                              child: DropdownMenu<String>(
                                                initialSelection: viewmodel.list.first,
                                                onSelected: (String? value) {
                                                  viewmodel.setDropDown = value!;
                                                },
                                                menuStyle: MenuStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color>(primaryContainer),
                                                ),
                                                dropdownMenuEntries: viewmodel.list.map<DropdownMenuEntry<String>>((String value) {
                                                  return DropdownMenuEntry<String>(value: value, label: value);
                                                }).toList(),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                          visible: (viewmodel.isValidChoice != null) ? ((viewmodel.isValidChoice!) ? false : true) : false,
                                          child: Text('You Must Choose an Item!',style: chooseItemTextError)
                                      )
                                    ],
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: primaryContainer,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.all(Radius.circular(15)),
                                  //   color: primaryContainer,
                                  // ),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            child: Text(
                                                TextStrings.addScreen_3,
                                                style: homeScreenReportText4
                                            ),
                                          )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child:  TextField(
                                          decoration:  InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  borderSide: BorderSide.none
                                              ),
                                              filled: true,
                                              labelText: TextStrings.addScreen_4,
                                              fillColor: backgroundColor,
                                              prefixIcon: Icon(Icons.search)
                                          ),
                                          minLines: 1,
                                          maxLines: 3,
                                          onChanged: (value){
                                            viewmodel.setQuery = value;
                                          },
                                        ),
                                      ),
                                      Visibility(
                                          visible: (args == ScreenType.Exercise.name) ? true : false,
                                          child:  Padding(
                                            padding: EdgeInsets.all(8),
                                            child:  TextField(
                                              decoration:  InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20.0),
                                                      borderSide: BorderSide.none
                                                  ),
                                                  filled: true,
                                                  labelText: 'Duration (In minutes , optional)',
                                                  fillColor: backgroundColor,
                                                  prefixIcon: Icon(Icons.timer_rounded)
                                              ),
                                              maxLines: 1,
                                              onChanged: (value){
                                                viewmodel.setQuery2 = value;
                                              },
                                            ),
                                          ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              foregroundColor: onPrimaryColor,
                                              shape: RoundedRectangleBorder( //to set border radius to button
                                                  borderRadius: BorderRadius.circular(0)
                                              ),
                                            ),
                                            onPressed: () async {
                                              if(viewmodel.searchQuery != null && viewmodel.searchQuery != ''){
                                                if(args == ScreenType.Meal.name) {
                                                  await viewmodel.getMealCalorie();
                                                  final result = await Navigator.pushNamed(context, '/calorieDetailScreen',arguments: viewmodel.response);
                                                  if(result == true) viewmodel.setInformation(null);
                                                }
                                                else {
                                                  await viewmodel.getActivityCalorie();
                                                  final result = await Navigator.pushNamed(context, '/burnedCalorieDetailScreen',arguments: viewmodel.response2);
                                                  if(result != null) viewmodel.setInformation(result as int?);
                                                }
                                              }

                                            },
                                            child: Text(TextStrings.addScreen_5),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              foregroundColor: onPrimaryColor,
                                              shape: RoundedRectangleBorder( //to set border radius to button
                                                  borderRadius: BorderRadius.circular(0)
                                              ),
                                            ),
                                            onPressed: () {
                                              openDialog(context,TextStrings.addScreen_6, (args == ScreenType.Meal.name) ? TextStrings.usingInstruction1 : TextStrings.usingInstruction2);
                                            },
                                            child: Text(TextStrings.addScreen_7),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  )
                              ),
                            ),
                          ],
                        ),
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
        )
    );
  }
}