import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/utils/helpers.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/history_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/global_widgets/loading_indicator.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/recent_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/images.dart';
import '../../../../../core/styles/text_style.dart';
import '../../../../../data/auth/auth.dart';
import '../../../../../data/auth/firestore_repository.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final EasyInfiniteDateTimelineController _controller = EasyInfiniteDateTimelineController();
  DateTime _focusDate = DateTime.now();
  final Auth auth = Auth();
  final Firestore firestore = Firestore();

  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HistoryViewModel>().focusDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Consumer<HistoryViewModel>(
            builder: (context,viewmodel,child) {
              return Column(
                children: [
                  SizedBox(height: 10),
                  EasyInfiniteDateTimeLine(
                    controller: _controller,
                    firstDate: DateTime(2023),
                    focusDate: viewmodel.focusDate,
                    lastDate: DateTime.now(),
                    onDateChange: (selectedDate) {
                      viewmodel.focusDate = selectedDate;
                    },
                    dayProps: EasyDayProps(
                      inactiveDayStyle:  DayStyle(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryContainer,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(25.0),
                            bottomLeft: Radius.circular(0)),
                      ),
                      child: Center(
                          child: (viewmodel.state == ResultState.loading) ? LoadingIndicator()
                              : Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    child: Text('Calories Remaining',style: petrolabTextTheme.titleLarge),
                                  )
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: 300,
                                child: Table(
                                  columnWidths: {
                                    0 : FractionColumnWidth(0.2),
                                    1 : FractionColumnWidth(0.05),
                                    2 : FractionColumnWidth(0.25),
                                    3 : FractionColumnWidth(0.05),
                                    4 : FractionColumnWidth(0.2),
                                    5 : FractionColumnWidth(0.05),
                                    6 : FractionColumnWidth(0.25),

                                  },
                                  children: [
                                    TableRow( children: [
                                      Text(viewmodel.logSummary.calorieBudget.toString(),style: petrolabTextTheme.bodyLarge,textAlign: TextAlign.center),
                                      Text('-',style: petrolabTextTheme.bodyLarge),
                                      Text(viewmodel.logSummary.consumedCalories.toString(),style: petrolabTextTheme.bodyLarge,textAlign: TextAlign.center),
                                      Text('+',style: petrolabTextTheme.bodyLarge,),
                                      Text(viewmodel.logSummary.burnedCalories.toString(),style: petrolabTextTheme.bodyLarge,textAlign: TextAlign.center),
                                      Text('=',style: petrolabTextTheme.bodyLarge),
                                      Text(viewmodel.logSummary.remainingCalories.toString(),style: caloriesLeft,textAlign: TextAlign.center),
                                    ]),
                                    TableRow( children: [
                                      Text('Goal',textAlign: TextAlign.center,style: caloriesLeft2,),
                                      Text(''),
                                      Text('Consumed',textAlign: TextAlign.center,style: caloriesLeft2),
                                      Text(''),
                                      Text('Burned',textAlign: TextAlign.center,style: caloriesLeft2),
                                      Text(''),
                                      Text('Remaining',textAlign: TextAlign.center,style: caloriesLeft2),
                                    ]),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    child: Text('Activity Log',style: petrolabTextTheme.titleLarge),
                                  )
                              ),
                              Expanded(
                                child: (viewmodel.state == ResultState.noData) ? Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        DefaultImages.not_found_image,
                                        height: MediaQuery.of(context).size.height * 0.35,
                                        width: MediaQuery.of(context).size.height * 0.35,
                                      ),
                                      Text('No Data For This Date',style: notFoundText),
                                    ],
                                  ),
                                ) : ListView.builder(
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    itemCount: viewmodel.activityList.length  ,
                                    itemBuilder: (BuildContext context, int index) {
                                      return RecentItem(content: viewmodel.activityList[index] , onTapped: () {},touchable: false,onNavigate: () {});
                                    }),
                              )


                            ],
                          )
                      ),
                    ),
                  )
                ],
              );
            },
          )
      ),
    );
  }
}

