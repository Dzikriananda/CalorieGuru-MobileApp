import 'dart:convert';

GetCalorieResponse getCalorieResponseFromJson(String str) => GetCalorieResponse.fromJson(json.decode(str));

String getCalorieResponseToJson(GetCalorieResponse data) => json.encode(data.toJson());

class GetCalorieResponse {
  int statusCode;
  String requestResult;
  Data data;

  GetCalorieResponse({
    required this.statusCode,
    required this.requestResult,
    required this.data,
  });

  factory GetCalorieResponse.fromJson(Map<String, dynamic> json) => GetCalorieResponse(
    statusCode: json["status_code"],
    requestResult: json["request_result"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "request_result": requestResult,
    "data": data.toJson(),
  };
}

class Data {
  double bmr;
  Goals goals;

  Data({
    required this.bmr,
    required this.goals,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bmr: json["BMR"]?.toDouble(),
    goals: Goals.fromJson(json["goals"]),
  );

  Map<String, dynamic> toJson() => {
    "BMR": bmr,
    "goals": goals.toJson(),
  };
}

class Goals {
  double maintainWeight;
  WeightLoss mildWeightLoss;
  WeightLoss weightLoss;
  WeightLoss extremeWeightLoss;
  WeightGain mildWeightGain;
  WeightGain weightGain;
  WeightGain extremeWeightGain;

  Goals({
    required this.maintainWeight,
    required this.mildWeightLoss,
    required this.weightLoss,
    required this.extremeWeightLoss,
    required this.mildWeightGain,
    required this.weightGain,
    required this.extremeWeightGain,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
    maintainWeight: json["maintain weight"]?.toDouble(),
    mildWeightLoss: WeightLoss.fromJson(json["Mild weight loss"]),
    weightLoss: WeightLoss.fromJson(json["Weight loss"]),
    extremeWeightLoss: WeightLoss.fromJson(json["Extreme weight loss"]),
    mildWeightGain: WeightGain.fromJson(json["Mild weight gain"]),
    weightGain: WeightGain.fromJson(json["Weight gain"]),
    extremeWeightGain: WeightGain.fromJson(json["Extreme weight gain"]),
  );

  Map<String, dynamic> toJson() => {
    "maintain weight": maintainWeight,
    "Mild weight loss": mildWeightLoss.toJson(),
    "Weight loss": weightLoss.toJson(),
    "Extreme weight loss": extremeWeightLoss.toJson(),
    "Mild weight gain": mildWeightGain.toJson(),
    "Weight gain": weightGain.toJson(),
    "Extreme weight gain": extremeWeightGain.toJson(),
  };
}

class WeightGain {
  String gainWeight;
  double calory;

  WeightGain({
    required this.gainWeight,
    required this.calory,
  });

  factory WeightGain.fromJson(Map<String, dynamic> json) => WeightGain(
    gainWeight: json["gain weight"],
    calory: json["calory"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "gain weight": gainWeight,
    "calory": calory,
  };
}

class WeightLoss {
  String lossWeight;
  double calory;

  WeightLoss({
    required this.lossWeight,
    required this.calory,
  });

  factory WeightLoss.fromJson(Map<String, dynamic> json) => WeightLoss(
    lossWeight: json["loss weight"],
    calory: json["calory"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "loss weight": lossWeight,
    "calory": calory,
  };
}
