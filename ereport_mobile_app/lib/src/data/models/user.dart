
class UserModel{
  String? UID;
  String? name;
  String? birthdate;
  bool? gender;
  double? weight;
  double? height;
  String? activityLevel;
  double? calorieNeed;
  bool? hasFilledData;

  // factory User.fromJson(Map<String,dynamic> map){
  //   return User(
  //     name = map['']
  //   )
  // }

  UserModel({
    this.UID,
    this.name,
    this.birthdate,
    this.gender,
    this.weight,
    this.height,
    this.activityLevel,
    this.calorieNeed,
    this.hasFilledData
  });

  factory UserModel.createFirstTime(){
    return UserModel(
        UID : null,
        name: null,
        birthdate: null,
        gender: null,
        weight: null,
        height: null,
        activityLevel : null,
        calorieNeed: null,
        hasFilledData: null
    );
  }

  factory UserModel.fromMap(Map<String,dynamic> map){
      return UserModel(
        UID: map['uid'],
        name: map['name'],
        birthdate: map['birthdate'],
        gender: map['gender'],
        weight: map['weight'],
        height: map['height'],
        activityLevel: map['activityLevel'],
        calorieNeed: map['calorieNeed'],
        hasFilledData: map['hasFilledData'],
      );
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'birthdate' : birthdate,
      'gender' : gender,
      'weight' : weight,
      'height' : height,
      'activityLevel' : activityLevel,
      'calorieNeed' : calorieNeed,
      'hasFilledData' : hasFilledData,
    };
  }



}