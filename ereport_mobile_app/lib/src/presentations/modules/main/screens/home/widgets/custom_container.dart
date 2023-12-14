import 'package:ereport_mobile_app/src/core/classes/icons.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget{
  final CustomIcon icon;
  final VoidCallback onTapped;
  final VoidCallback onMoved;


  const CustomContainer({Key? key,required this.icon,required this.onTapped,required this.onMoved}): super(key: key);

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
          widget.onMoved();
          final result = await Navigator.pushNamed(context, '/listScreen',arguments: {'name' : widget.icon.name,'isUpdate':false});
          if(result != null && result == true) {
            widget.onTapped();
          }
        },
        child: Container(
          height: MediaQuery. of(context). size. width * 0.25,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  blurRadius: 2,
                ),
              ],


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
                alignment: const Alignment(-1.0, 1.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 5, 8),
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