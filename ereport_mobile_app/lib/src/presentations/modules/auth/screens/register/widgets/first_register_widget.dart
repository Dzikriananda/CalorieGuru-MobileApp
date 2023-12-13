import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/register_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/register_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class FirstRegisterWidget extends StatefulWidget {
  final MyBuilder builder;
  const FirstRegisterWidget({Key? key,required this.builder}) : super(key: key);

  @override
  State<FirstRegisterWidget> createState() => _FirstRegisterWidgetState();
}

class _FirstRegisterWidgetState extends State<FirstRegisterWidget> {
  String? date;
  final _formKey = GlobalKey<FormState>();
  late RegisterViewModel registerViewModel;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    registerViewModel = Provider.of<RegisterViewModel>(context,listen: false);
  }


  bool onPressed(){
    registerViewModel.checkVisibility_firstPage();
    if(_formKey.currentState!.validate() && (registerViewModel.gender != null && registerViewModel.birthdate != null)){
      return true;
    }
    else {
      return false;
    }
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
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
                          initialValue: viewmodel.name,
                          backgroundColor: textField_1,
                          isEnabled: true,
                          hintText: TextStrings.registerScreen_1,
                          icon: const Icon(Icons.person),
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
                          initialValue: (viewmodel.weight == null || viewmodel.weight.toString() == '')? null : viewmodel.weight.toString(),
                          backgroundColor: textField_1,
                          isEnabled: true,
                          hintText: TextStrings.registerScreen_2,
                          icon: const Icon(Icons.monitor_weight_outlined),
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
                          initialValue: (viewmodel.height == null || viewmodel.weight.toString() == '')? null : viewmodel.height.toString(),
                          backgroundColor: textField_1,
                          isEnabled: true,
                          hintText: TextStrings.registerScreen_3,
                          icon: const Icon(Icons.height),
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
                Text(TextStrings.registerScreen_4,style: petrolabTextTheme.bodyLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (viewmodel.gender != null && viewmodel.gender == true) ? primaryColor : backgroundColor,
                        side: const BorderSide(
                          width: 1.0,
                          color: primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                        minimumSize: const Size(110,36),
                        maximumSize: const Size(110,36),
                      ),
                      onPressed: () {
                        if(viewmodel.gender ==  null || viewmodel.gender == false) {
                          viewmodel.setGender(true);
                        } else {
                          viewmodel.setGender(null);
                        }
                      },
                      child: const Text(TextStrings.registerScreen_5,style: TextStyle(color: onPrimaryContainer)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (viewmodel.gender != null && viewmodel.gender == false) ? primaryColor : backgroundColor,
                        side: const BorderSide(
                          width: 1.0,
                          color: primaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                        minimumSize: const Size(110,36),
                        maximumSize: const Size(110,36),
                      ),
                      onPressed: () {
                        if(viewmodel.gender ==  null || viewmodel.gender == true) {
                          viewmodel.setGender(false);
                        } else {
                          viewmodel.setGender(null);
                        }
                      },
                      child: const Text(TextStrings.registerScreen_6,style: TextStyle(color: onPrimaryContainer)),
                    ),
                  ],
                ),
                Visibility(
                    visible: viewmodel.visible1,
                    child: const Text(
                      TextStrings.invalidNullOptionWarning,
                      style: TextStyle(
                          color: Colors.red
                      ),
                    )
                ),
                const SizedBox(height: 20),
                Text(TextStrings.registerScreen_7,style: petrolabTextTheme.bodyLarge),
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
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate:DateTime.now().subtract(const Duration(days: 29218)), //DateTime.now() - 80 Years.
                        lastDate: DateTime.now()
                    );
                    if(pickedDate != null){
                      viewmodel.birthdate = pickedDate.toString();
                    }
                  },
                  child: Text((viewmodel.birthdate == null)? TextStrings.registerScreen_8 : DateFormat('yMMMMd').format(DateTime.parse(viewmodel.birthdate!)),style: const TextStyle(color: onPrimaryContainer)),
                ),
                Visibility(
                    visible: viewmodel.visible2,
                    child: const Text(
                      TextStrings.invalidNullOptionWarning,
                      style: TextStyle(
                          color: Colors.red
                      ),
                    )
                ),
              ],
            ),
          );
        }
    );
  }
}