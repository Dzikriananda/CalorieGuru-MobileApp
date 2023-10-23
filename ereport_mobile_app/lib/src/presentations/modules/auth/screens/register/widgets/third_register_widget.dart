import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
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

          }
          return Center(
            child: (viewmodel.state == ResultState.loading)? Column(
              children: [
                Image.asset(
                  "assets/icons/loading_icon.gif",
                  height: 300.0,
                  width: 300.0,
                ),
                Text("Finding best result for you.....")
              ],
            ) : Column(
              children: [
                Text('Congratulations!', style: petrolabTextTheme.headlineMedium,textAlign: TextAlign.center),
                SizedBox(height: 50),
                Text('Your plan is ready and youre a step\ncloser to maintain youre weight',style: petrolabTextTheme.bodyLarge,textAlign: TextAlign.center),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      Text('Your daily calorie intake is : ',style: calorieText,textAlign: TextAlign.center),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${viewmodel.response.data.goals.maintainWeight.toInt()}',style: calorieTextSecond,textAlign: TextAlign.center),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            height: 30,
                            width: 120,
                            child: Center(
                              child: Text("Calories",style: petrolabTextTheme.headlineSmall),
                            )
                          )

                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.40),
                Text('*You can still change your personal information later')


              ],
            )
          );
        }
    );
  }
}