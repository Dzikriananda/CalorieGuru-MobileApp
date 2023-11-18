
class DailyLogSummary {
    double? consumedCalories;
    double? calorieBudget;
    double? burnedCalories;
    double? remainingCalories;

    DailyLogSummary(double consumedCal, double calBudget, double burnedCal) {
      consumedCalories = consumedCal;
      calorieBudget = calBudget;
      burnedCalories = burnedCal;
      remainingCalories = calBudget - (consumedCal - burnedCal);
    }

    factory DailyLogSummary.fromMap(Map<String,dynamic> map) {
      final consumedCal = map['consumedCalories'];
      final calBudget = map['calorieBudget'];
      final burnedCal = map['burnedCalories'];
      return DailyLogSummary(consumedCal, calBudget, burnedCal);
    }


}