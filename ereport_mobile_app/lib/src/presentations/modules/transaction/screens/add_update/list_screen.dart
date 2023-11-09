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
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController calorieController = TextEditingController();
  String dropdownValue = list.first;


  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    foodNameController.dispose();
    calorieController.dispose();
    super.dispose();
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
                textAlign: TextAlign.center,
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

    final args = ModalRoute.of(context)!.settings.arguments as String;
    return WillPopScope(
        onWillPop: () async {
          if ( context.read<AddUpdateViewModel>().state == ResultState.loading) return false;
          else return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('$args', style: TextStyle(color: onPrimaryColor)),
              backgroundColor: primaryColor,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  context.read<AddUpdateViewModel>().setMealName = foodNameController.text;
                  context.read<AddUpdateViewModel>().setCalorie = calorieController.text;
                  final result = await context.read<AddUpdateViewModel>().addLog();
                  if(result){
                    context.read<AddUpdateViewModel>().disposeViewModel();
                    Navigator.of(context).pop(true);
                  }
                  else{
                    openDialog(context, 'Adding Log', 'Adding is Failed! Try Again!');
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
                calorieController.text = ((viewmodel.calorie != null )? viewmodel.calorie.toString() : '');
                foodNameController.text = ((viewmodel.mealName != null )? viewmodel.mealName! : '');
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
                                                TextStrings.addScreen_1,
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
                                              hintText: 'Food name',
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
                                              textfieldController: foodNameController,
                                            ),
                                            CustomFormField(
                                              hasUnderline: true,
                                              backgroundColor: primaryContainer,
                                              hintText: 'Calorie (in Kcal)',
                                              icon: null,
                                              initialValue: null,
                                              isEnabled: true,
                                              isPassword: false,
                                              validator: (val) {
                                                if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                                              },
                                              onSubmited: (value){
                                              },
                                              maxLines: 1,
                                              textfieldController: calorieController,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(25, 0, 0, 25),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(TextStrings.addScreen_2,style: petrolabTextTheme.titleLarge,),
                                            DropdownMenu<String>(
                                              initialSelection: list.first,
                                              onSelected: (String? value) {
                                                viewmodel.setDropDown = value!;
                                              },
                                              menuStyle: MenuStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(primaryContainer),
                                              ),
                                              dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                                                return DropdownMenuEntry<String>(value: value, label: value);
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(height: 0),
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
                                            viewmodel.setQueryMealName = value;
                                          },
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
                                              if(viewmodel.searchMealQuery != null && viewmodel.searchMealQuery != ''){
                                                await viewmodel.getMealCalorie();
                                                var result = await Navigator.pushNamed(context, '/calorieDetailScreen',arguments: viewmodel.response);
                                                if(result == true ) viewmodel.setInformation();
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
                                              openDialog(context,TextStrings.addScreen_6, TextStrings.usingInstruction);
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