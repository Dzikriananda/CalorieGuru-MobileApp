import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/history_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/global_widgets/loading_indicator.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/recent_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/images.dart';
import '../../../../../core/styles/text_style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final EasyInfiniteDateTimelineController _controller = EasyInfiniteDateTimelineController();

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
                  const SizedBox(height: 10),
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
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: primaryContainer,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(25.0),
                            bottomLeft: Radius.circular(0)),
                      ),
                      child: Center(
                          child: (viewmodel.state == ResultState.loading) ? const LoadingIndicator()
                              : Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    child: Text(TextStrings.historyScreen_1,style: petrolabTextTheme.titleLarge),
                                  )
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 300,
                                child: Table(
                                  columnWidths: const {
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
                                    const TableRow( children: [
                                      Text(TextStrings.historyScreen_2,textAlign: TextAlign.center,style: caloriesLeft2,),
                                      Text(''),
                                      Text(TextStrings.historyScreen_3,textAlign: TextAlign.center,style: caloriesLeft2),
                                      Text(''),
                                      Text(TextStrings.historyScreen_4,textAlign: TextAlign.center,style: caloriesLeft2),
                                      Text(''),
                                      Text(TextStrings.historyScreen_5,textAlign: TextAlign.center,style: caloriesLeft2),
                                    ]),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    child: Text(TextStrings.historyScreen_6,style: petrolabTextTheme.titleLarge),
                                  )
                              ),
                              Expanded(
                                child: (viewmodel.state == ResultState.noData) ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      DefaultImages.not_found_image,
                                      height: MediaQuery.of(context).size.height * 0.35,
                                      width: MediaQuery.of(context).size.height * 0.35,
                                    ),
                                    const Text(TextStrings.historyScreen_7,style: notFoundText),
                                  ],
                                ) : ListView.builder(
                                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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

