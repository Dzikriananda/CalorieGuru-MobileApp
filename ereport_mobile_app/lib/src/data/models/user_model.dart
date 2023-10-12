
class LocalUser{
  late String name;
  late String workPlace;
  late String position;

  LocalUser.fromMap(Map map){
    this.name = map["name"];
    this.workPlace = map["workplace"];
    this.position = map["position"];
  }

}