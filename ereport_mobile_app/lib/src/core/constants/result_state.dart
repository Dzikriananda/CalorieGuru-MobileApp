import 'activity_level.dart';

enum ResultState { started,loading, noData, hasData, error,noConnection, logged,unLogged,loggedNotFilledData,addDataSuccess}
enum Gender { male, female}
// enum ActivityLevel {level_1,level_2,level_3,level_4,level_5,level_6}
const List<String> activityLevelText = [
  "Sedentary: little or no exercise",
  "Exercise 1-3 times/week",
  "Exercise 4-5 times/week",
  "Daily exercise or intense exercise 3-4 times/week",
  "Intense exercise 6-7 times/week",
  "Very intense exercise daily, or physical job",
];

Map<ActivityLevel,String> activityLevelMap = {
  ActivityLevel.level_1 : "Sedentary: little or no exercise",
  ActivityLevel.level_2 : "Exercise 1-3 times/week",
  ActivityLevel.level_3 : "Exercise 4-5 times/week",
  ActivityLevel.level_4 : "Daily exercise or intense exercise 3-4 times/week",
  ActivityLevel.level_5 : "Intense exercise 6-7 times/week",
  ActivityLevel.level_6 : "Very intense exercise daily, or physical job",



};
