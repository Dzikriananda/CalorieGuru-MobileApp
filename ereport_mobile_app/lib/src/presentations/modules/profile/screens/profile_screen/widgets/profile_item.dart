import 'package:flutter/material.dart';
class ProfileItem extends StatefulWidget {
  Widget item;
  ProfileItem({Key? key,required this.item}) : super(key: key);

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: widget.item,
    );
  }
}