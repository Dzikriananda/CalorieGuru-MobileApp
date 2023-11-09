import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'custom_container.dart';

class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      itemCount: 20,
      itemBuilder: (BuildContext ctxt, int index) {
        return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Eat Food for 400 Kkal'),
                  Icon(Icons.food_bank,size: 40)
                ],
              ),
            )
        );
      },
    );
  }
}