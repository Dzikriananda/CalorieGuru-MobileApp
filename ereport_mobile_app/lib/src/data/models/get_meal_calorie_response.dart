class CheckMealCalorieResponse {
  List<Item> items;

  CheckMealCalorieResponse({
    required this.items,
  });

  factory CheckMealCalorieResponse.fromJson(Map<String, dynamic> json) => CheckMealCalorieResponse(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String name;
  double calories;
  double servingSizeG;
  double fatTotalG;
  double fatSaturatedG;
  double proteinG;
  int sodiumMg;
  int potassiumMg;
  int cholesterolMg;
  double carbohydratesTotalG;
  double fiberG;
  double sugarG;

  Item({
    required this.name,
    required this.calories,
    required this.servingSizeG,
    required this.fatTotalG,
    required this.fatSaturatedG,
    required this.proteinG,
    required this.sodiumMg,
    required this.potassiumMg,
    required this.cholesterolMg,
    required this.carbohydratesTotalG,
    required this.fiberG,
    required this.sugarG,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"],
    calories: json["calories"]?.toDouble(),
    servingSizeG: json["serving_size_g"]?.toDouble(),
    fatTotalG: json["fat_total_g"]?.toDouble(),
    fatSaturatedG: json["fat_saturated_g"]?.toDouble(),
    proteinG: json["protein_g"],
    sodiumMg: json["sodium_mg"],
    potassiumMg: json["potassium_mg"],
    cholesterolMg: json["cholesterol_mg"],
    carbohydratesTotalG: json["carbohydrates_total_g"]?.toDouble(),
    fiberG: json["fiber_g"]?.toDouble(),
    sugarG: json["sugar_g"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "calories": calories,
    "serving_size_g": servingSizeG,
    "fat_total_g": fatTotalG,
    "fat_saturated_g": fatSaturatedG,
    "protein_g": proteinG,
    "sodium_mg": sodiumMg,
    "potassium_mg": potassiumMg,
    "cholesterol_mg": cholesterolMg,
    "carbohydrates_total_g": carbohydratesTotalG,
    "fiber_g": fiberG,
    "sugar_g": sugarG,
  };
}