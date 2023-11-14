import 'dart:convert';
import 'package:ereport_mobile_app/src/data/models/get_calorie_response.dart';
import 'package:ereport_mobile_app/src/data/models/get_meal_calorie_response.dart';
import 'package:http/http.dart' as http;

class ApiService{
  final String baseUrl = 'https://fitness-calculator.p.rapidapi.com/dailycalorie';
  final String baseUrl2 = 'https://api.api-ninjas.com/v1/caloriesburned';

  Future<String> checkCalorie(Map<String,dynamic> qParams) async {
    Uri query = Uri.parse(baseUrl);
    final finalUri = query.replace(queryParameters: qParams);
    final response = await http.get(
      finalUri,
      headers: <String, String>{
        "X-RapidAPI-Key" : "9bb9272d1fmshb9444150d90e28ep142234jsn66c048e4f1db",
        "X-RapidAPI-Host" : "fitness-calculator.p.rapidapi.com",
      },
    );
    return response.body;
  }

  Future<String> checkMealCalorie(String mealName) async {
    Uri finalUri = Uri.parse('https://api.calorieninjas.com/v1/nutrition?query=$mealName');
    final response = await http.get(
      finalUri,
      headers: <String, String>{
        'X-Api-Key' : 'UI3fZaxmCMJAYamhD5mH3A==dJaPAKk64d9KcofT'
      },
    );
    return response.body;
  }

  Future<String> checkBurnedCalorie(String activityName,int? duration) async {
    Map<String,dynamic> qParams = {
      'activity' : activityName,
      'duration' : '$duration'
    };
    Uri uri = Uri.parse(baseUrl2);
    Uri finalUri = uri.replace(queryParameters: qParams);
    final response = await http.get(
      finalUri,
      headers: <String, String>{
        'X-Api-Key' : 'UI3fZaxmCMJAYamhD5mH3A==BBCP2aBqaC9u9P6E'
      },
    );
    print(response.body);
    return response.body;
  }


}