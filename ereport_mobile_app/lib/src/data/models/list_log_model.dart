
class LogModel{
  String? instanceName;
  String? instanceType;
  String? type;
  double? calories;
  int? no;

  LogModel({
    this.instanceName,
    this.instanceType,
    this.type,
    this.calories,
    this.no,
  });

  factory LogModel.fromMap(Map<String,dynamic> map){
    return LogModel(
      instanceName: map['log_instance_name'],
      instanceType: map['log_instance_type'],
      type: map['type'],
      calories: map['calories'],
      no: map['no'],
    );
  }

  Map<String,dynamic> toMap(){
    return {

    };
  }



}