
import 'package:flutter/material.dart';

class CustomIcon{
  late String name;
  String? path;
  Icon? icon;

  CustomIcon(this.name,this.path,this.icon);

  factory CustomIcon.fromPath(String nameInput,String pathInput){
    return CustomIcon(nameInput,pathInput,null);
  }

  factory CustomIcon.fromIcon(String nameInput,Icon iconInput){
    return CustomIcon(nameInput,null,iconInput);
  }
}