import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdRegisterWidget extends StatefulWidget {
  const ThirdRegisterWidget({Key? key}) : super(key: key);

  @override
  State<ThirdRegisterWidget> createState() => _ThirdRegisterWidgetState();
}

class _ThirdRegisterWidgetState extends State<ThirdRegisterWidget> {

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
        builder: (context,viewmodel,child){
          if(viewmodel.state == ResultState.loading){
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      DefaultImages.loading_1,
                      height: 300.0,
                      width: 300.0,
                    ),
                    Text(TextStrings.registerScreen_10,style: petrolabTextTheme.titleLarge,)
                  ],
                ),
              );
          }
          else if(viewmodel.state == ResultState.hasData){
            return Center(
                child: Column(
                  children: [
                    Text(TextStrings.registerScreen_11, style: petrolabTextTheme.headlineMedium,textAlign: TextAlign.center),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(TextStrings.registerScreen_12,style: petrolabTextTheme.bodyLarge,textAlign: TextAlign.center),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                      child: Column(
                        children: [
                          const Text(TextStrings.registerScreen_13,style: calorieText,textAlign: TextAlign.center),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text((viewmodel.response == null)? '': viewmodel.response!.data.goals.maintainWeight.toStringAsFixed(1),style: calorieTextSecond,textAlign: TextAlign.center),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      color: Colors.grey,
                                      borderRadius: const BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Center(
                                    child: Text(TextStrings.registerScreen_14,style: petrolabTextTheme.headlineSmall),
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Container(
                            height: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.40),
                    Text(TextStrings.registerScreen_15,style: petrolabTextTheme.bodyMedium)
                  ],
                )
            );
          }
          else{
            return const Center();
          }
        }
    );
  }
}