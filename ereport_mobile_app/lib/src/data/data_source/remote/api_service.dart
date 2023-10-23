import 'dart:convert';
import 'package:ereport_mobile_app/src/data/models/get_calorie_response.dart';
import 'package:http/http.dart' as http;

class ApiService{
  final String baseUrl = 'https://fitness-calculator.p.rapidapi.com/dailycalorie';

  Future<String> checkCalorie(Map<String,dynamic> qParams) async {

    Uri query = Uri.parse(baseUrl);
    final finalUri = query.replace(queryParameters: qParams);
    print(finalUri.toString());

    final response = await http.get(
      finalUri,
      headers: <String, String>{
        "X-RapidAPI-Key" : "9bb9272d1fmshb9444150d90e28ep142234jsn66c048e4f1db",
        "X-RapidAPI-Host" : "fitness-calculator.p.rapidapi.com",
      },
    );

    return response.body;
  }

}