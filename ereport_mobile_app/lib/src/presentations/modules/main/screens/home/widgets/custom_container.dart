import 'package:ereport_mobile_app/src/core/classes/icons.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomContainer extends StatefulWidget{
  final CustomIcon icon;
  final VoidCallback onTapped;


  CustomContainer({Key? key,required this.icon,required this.onTapped}): super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.pushNamed(context, '/listScreen',arguments: widget.icon.name);
          if(result != null && result == true) {
            widget.onTapped();
          }
        },
        child: Container(
          height: MediaQuery. of(context). size. width * 0.25,
          decoration: const BoxDecoration(
              color: primaryContainer,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(23, 8, 0, 0),
                    child: widget.icon.icon
                ),
              ),
              Align(
                alignment: Alignment(-1.0, 1.0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 5, 8),
                  child: Text(
                    widget.icon.name,
                    style: containerOptionText,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}