import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/register_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/register_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:age_calculator/age_calculator.dart';

class FirstRegisterWidget extends StatefulWidget {
  final MyBuilder builder;
  const FirstRegisterWidget({Key? key,required this.builder}) : super(key: key);

  @override
  State<FirstRegisterWidget> createState() => _FirstRegisterWidgetState();
}

class _FirstRegisterWidgetState extends State<FirstRegisterWidget> {
  String? date;
  final _formKey = GlobalKey<FormState>();
  bool _visible1 = false;
  bool _visible2 = false;


  bool onPressed(){
    if(Provider.of<RegisterViewModel>(context,listen: false).birthdate == null){
      setState(() {
        _visible2 = true;
      });
    }
    else{
      setState(() {
        _visible2 = false;
      });
    }
    if(_formKey.currentState!.validate()){
      return true;
    }
    else return false;
  }


  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, onPressed);
    return Consumer<RegisterViewModel>(
        builder: (context,viewmodel,child){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomFormField(
                          readOnly: false,
                          onTap: () {},
                          suffixIcon: null,
                          margin: 8.0,
                          hasUnderline: true,
                          maxLines: 1,
                          initialValue: (viewmodel.name == null)? null : viewmodel.name.toString(),
                          backgroundColor: primaryContainer,
                          isEnabled: true,
                          hintText: "Full Name",
                          icon: Icon(Icons.person),
                          isPassword: false,
                          validator: (val){
                            if(!val!.isNotNull) return TextStrings.invalidNameWarning;
                          },
                          onSubmited: (value){
                            viewmodel.name = value;
                          },
                        ),
                        CustomFormField(
                          readOnly: false,
                          onTap: () {},
                          suffixIcon: null,
                          margin: 8.0,
                          hasUnderline: true,
                          maxLines: 1,
                          initialValue: (viewmodel.weight == null || viewmodel.weight == '')? null : viewmodel.weight.toString(),
                          backgroundColor: primaryContainer,
                          isEnabled: true,
                          hintText: "Weight (in Kg)",
                          icon: Icon(Icons.monitor_weight_outlined),
                          isPassword: false,
                          validator: (val) {
                            if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                            if (!val!.isValidWeight) return TextStrings.invalidWeightWarning;

                          },
                          onSubmited: (value){
                            if(value != ''){
                              viewmodel.weight = double.parse(value);
                            }
                          },
                        ),
                        CustomFormField(
                          readOnly: false,
                          onTap: () {},
                          suffixIcon: null,
                          margin: 8.0,
                          hasUnderline: true,
                          maxLines: 1,
                          initialValue: (viewmodel.height == null || viewmodel.weight == '')? null : viewmodel.height.toString(),
                          backgroundColor: primaryContainer,
                          isEnabled: true,
                          hintText: "Height (in Cm)",
                          icon: Icon(Icons.height),
                          isPassword: false,
                          validator: (val) {
                            if (!val!.isNotNull) return TextStrings.invalidNullWarning;
                            if (!val!.isValidHeight) return TextStrings.invalidHeightlWarning;
                          },
                          onSubmited: (value){
                            if(value != ''){
                              viewmodel.height = double.parse(value);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ),
                Text("You Are a ?",style: petrolabTextTheme.bodyLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text("Female",style: TextStyle(color: onPrimaryContainer)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (viewmodel.gender != null && viewmodel.gender == true) ? primaryColor : backgroundColor,
                        side: BorderSide(
                          width: 1.0,
                          color: primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                        minimumSize: Size(110,36),
                        maximumSize: Size(110,36),
                      ),
                      onPressed: () {
                        if(viewmodel.gender ==  null || viewmodel.gender == false) viewmodel.setGender(true);
                        else viewmodel.setGender(null);
                      },
                    ),
                    ElevatedButton(
                      child: Text("Male",style: TextStyle(color: onPrimaryContainer)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (viewmodel.gender != null && viewmodel.gender == false) ? primaryColor : backgroundColor,
                        side: BorderSide(
                          width: 1.0,
                          color: primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                        minimumSize: Size(110,36),
                        maximumSize: Size(110,36),
                      ),
                      onPressed: () {
                        if(viewmodel.gender ==  null || viewmodel.gender == true) viewmodel.setGender(false);
                        else viewmodel.setGender(null);
                      },
                    ),
                  ],
                ),
                Visibility(
                    child: Text(
                      TextStrings.invalidNullOptionWarning,
                      style: TextStyle(
                          color: Colors.red
                      ),
                    ),
                    visible: _visible1
                ),
                SizedBox(height: 20),
                Text("When were you born?",style: petrolabTextTheme.bodyLarge),
                ElevatedButton(
                  child: Text((viewmodel.birthdate == null)? "PICK DATE" : DateFormat('yMMMMd').format(DateTime.parse(viewmodel.birthdate!)),style: TextStyle(color: onPrimaryContainer)),
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
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate:DateTime.now().subtract(Duration(days: 29218)), //DateTime.now() - 80 Years.
                        lastDate: DateTime.now()
                    );
                    if(pickedDate != null){
                      viewmodel.birthdate = pickedDate.toString();
                    }
                  },
                ),
                Visibility(
                    child: Text(
                      TextStrings.invalidNullOptionWarning,
                      style: TextStyle(
                          color: Colors.red
                      ),
                    ),
                    visible: _visible2
                ),
              ],
            ),
          );
        }
    );
  }
}