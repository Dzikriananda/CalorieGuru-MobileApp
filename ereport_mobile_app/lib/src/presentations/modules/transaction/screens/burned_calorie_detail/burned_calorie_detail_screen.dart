import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/screen_type.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/models/get_burned_calorie_response.dart';
import 'package:ereport_mobile_app/src/presentations/modules/transaction/widgets/not_found_widget.dart';
import 'package:flutter/material.dart';

List<String> labels = [
  'Name',
  'Total Calories Burned',
  'Duration',
  'Calories Burned per Hour',
  'Actions'
];

class BurnedCalorieDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<BurnedCalorieResponse>;
    return Scaffold(
        appBar:  AppBar(
          title: Text('Activity Details', style: TextStyle(color: onPrimaryColor)),
          backgroundColor: primaryColor,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child:  Padding(
                  padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                  child: args.isNotEmpty? Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: primaryContainer,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DataTable(
                                columns: [
                                  ...labels.map((e) {return DataColumn(label: Text(e));})
                                ],
                                rows: [
                                  ...args.asMap().entries.map(
                                          (e){
                                          return DataRow(cells: [
                                            DataCell(Text(e.value.name,style: petrolabTextTheme.bodyMedium)),
                                            DataCell(Text(e.value.totalCalories.toString(),style: petrolabTextTheme.bodyMedium)),
                                            DataCell(Text(e.value.durationMinutes.toString(),style: petrolabTextTheme.bodyMedium)),
                                            DataCell(Text(e.value.caloriesPerHour.toString(),style: petrolabTextTheme.bodyMedium)),
                                            DataCell(
                                                OutlinedButton(
                                                  child: Text('Use This'),
                                                  onPressed: () {
                                                    print(e.key);
                                                    Navigator.pop(context,e.key);

                                                  },
                                                )
                                            ),
                                        ]);
                                      }
                                  ),
                                ],
                              ),

                            ],
                          )
                      ),
                    ),
                  ) : NotFoundWidget(type: ScreenType.Exercise)
              ),
            )
        )
    );

  }
}
