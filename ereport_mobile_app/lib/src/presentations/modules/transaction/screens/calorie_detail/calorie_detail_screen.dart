import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/models/get_meal_calorie_response.dart';
import 'package:flutter/material.dart';

List<String> labels = [
  'Name',
  'Calories',
  'Serving Size (gram)',
  'Fat Total (gram)',
  'Fat Saturated (gram)',
  'Protein (gram)',
  'Cholesterol (Mg)',
  'Sodium (Mg)',
  'Carbohydrates (gram)',
  'Fiber (gram)',
  'Sugar (gram)',
];

class CalorieDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CheckMealCalorieResponse;
    final double totalCal = args.items.fold(0, (sum, element) => sum + element.calories);

    return Scaffold(
      appBar:  AppBar(
        title: Text('Nutrition Details', style: TextStyle(color: onPrimaryColor)),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
              child: args.items.isNotEmpty? Scrollbar(
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
                              ...args.items.map(
                                      (e){
                                    return DataRow(cells: [
                                      DataCell(Text(e.name,style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.calories.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.servingSizeG.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.fatTotalG.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.fatSaturatedG.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.proteinG.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.cholesterolMg.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.sodiumMg.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.carbohydratesTotalG.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.fiberG.toString(),style: petrolabTextTheme.bodyMedium)),
                                      DataCell(Text(e.sugarG.toString(),style: petrolabTextTheme.bodyMedium)),
                                    ]);
                                  }
                              ),
                            ],
                          ),
                          Text('Total Calories : $totalCal',style: totalCalText,),
                          SizedBox(height: 10),
                          // Text('Swipe to the right >>>'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    foregroundColor: onPrimaryColor,
                                    shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context,true);
                                },
                                child: Text('Use this data'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    foregroundColor: onPrimaryColor,
                                    shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context,false);
                                },
                                child: Text('Discard'),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                ),
              ) : Center(
                child: Container(
                  width: MediaQuery.of(context).size.width ,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: primaryContainer,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        DefaultImages.not_found_image,
                        height: 150,
                        width: 150,
                      ),
                      Text(TextStrings.nutritionDetail_1,style: notFoundText,textAlign: TextAlign.center,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: onPrimaryColor,
                            shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(15)
                            ),
                        ),
                        onPressed: () {
                          Navigator.pop(context,false);
                        },
                        child: Text('Back'),
                      ),
                    ],
                  )
                ),
              )
          ),
        )
      )
    );

  }
}

// Table(
//   border: TableBorder.all(color: onPrimaryContainer, width: 1),
//   children:  [
//     TableRow(
//         children: [
//           Text('Name',style: petrolabTextTheme.bodyMedium),
//           Text('Calories',style: petrolabTextTheme.bodyMedium),
//           Text('Serving Size (gram)',style: petrolabTextTheme.bodyMedium),
//           Text('Fat Total (gram)',style: petrolabTextTheme.bodyMedium),
//           Text('Fat Saturated (gram)',style: petrolabTextTheme.bodyMedium),
//           Text('Protein (gram)',style: petrolabTextTheme.bodyMedium),
//           Text('Cholestrol (Mg)',style: petrolabTextTheme.bodyMedium),
//           Text('Sodium (Mg)',style: petrolabTextTheme.bodyMedium),
//           Text('Carbohydrates (gram)',style: petrolabTextTheme.bodyMedium),
//           Text('Fiber (gram)',style: petrolabTextTheme.bodyMedium),
//           Text('Sugar (gram)',style: petrolabTextTheme.bodyMedium),
//         ]
//     ),
//     ...args.items.map((e) {
//       return TableRow(children: [
//         Text(e.name,style: petrolabTextTheme.bodyMedium),
//         Text(e.calories.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.servingSizeG.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.fatTotalG.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.fatSaturatedG.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.proteinG.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.cholesterolMg.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.sodiumMg.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.carbohydratesTotalG.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.fiberG.toString(),style: petrolabTextTheme.bodyMedium),
//         Text(e.sugarG.toString(),style: petrolabTextTheme.bodyMedium),
//       ]);
//     }
//     ),
//   ],
// ),