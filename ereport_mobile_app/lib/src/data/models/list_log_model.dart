
class ListLogModel{
  String? instanceName;
  String? instanceType;
  String? type;
  double? calories;
  int? no;

  ListLogModel({
    this.instanceName,
    this.instanceType,
    this.type,
    this.calories,
    this.no,
  });

  factory ListLogModel.fromMap(Map<String,dynamic> map){
    return ListLogModel(
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