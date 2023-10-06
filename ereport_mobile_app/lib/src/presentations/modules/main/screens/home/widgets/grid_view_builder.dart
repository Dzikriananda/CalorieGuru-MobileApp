import 'package:ereport_mobile_app/src/core/classes/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'custom_container.dart';

class GridViewBuilder extends StatefulWidget {
  final List<CustomIcon> icons;

  GridViewBuilder({Key? key,required this.icons}) : super(key: key);

  @override
  State<GridViewBuilder> createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      itemCount: widget.icons.length,
      itemBuilder: (context, index) {
        return CustomContainer(icon: widget.icons[index]);
      },
    );
  }
}