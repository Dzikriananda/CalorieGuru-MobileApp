

import 'dart:convert';

List<BurnedCalorieResponse> burnedCalorieResponseFromJson(String str) => List<BurnedCalorieResponse>.from(json.decode(str).map((x) => BurnedCalorieResponse.fromJson(x)));

class BurnedCalorieResponse {
  String name;
  int caloriesPerHour;
  int durationMinutes;
  int totalCalories;

  BurnedCalorieResponse({
    required this.name,
    required this.caloriesPerHour,
    required this.durationMinutes,
    required this.totalCalories,
  });

  factory BurnedCalorieResponse.fromJson(Map<String, dynamic> json) => BurnedCalorieResponse(
    name: json["name"],
    caloriesPerHour: json["calories_per_hour"],
    durationMinutes: json["duration_minutes"],
    totalCalories: json["total_calories"],
  );

}
