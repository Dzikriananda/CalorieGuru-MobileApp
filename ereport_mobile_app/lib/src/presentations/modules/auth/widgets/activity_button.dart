
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ActivityOptionsButton extends StatefulWidget {
  String title;
  // VoidCallback onTap;
  int index;

  ActivityOptionsButton({Key? key,required this.title,required this.index}) : super(key: key);

  @override
  State<ActivityOptionsButton> createState() => _ActivityOptionsButtonState();
}

class _ActivityOptionsButtonState extends State<ActivityOptionsButton> {
  Color color = primaryContainer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Consumer<RegisterViewModel>(
        builder: (context,viewModel,child) => ElevatedButton(
          child: Text(widget.title,style: TextStyle(color: (viewModel.choosedIndex == widget.index)? onPrimaryColor : onPrimaryContainer)),
          style: ElevatedButton.styleFrom(
              backgroundColor: (viewModel.choosedIndex == widget.index) ? primaryColor : primaryContainer,
              minimumSize: Size(350,50),
              maximumSize: Size(350,50),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0,
        ),
        onPressed: () {
            viewModel.pressedButton(widget.index);
        },
       ),
      )
    );
  }
}