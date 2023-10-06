import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'custom_container.dart';

class ListViewBuilder extends StatefulWidget {
  final ScrollController scrollController;
  final List<String> image;
  const ListViewBuilder({Key? key,required this.scrollController,required this.image}) : super(key: key);

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext ctxt, int index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: CachedNetworkImage(
            imageUrl: widget.image[index],
            width: MediaQuery. of(context). size. width * 0.6,
            placeholder: (context,url) => Container(),
            errorWidget: (context,url,error) => new Icon(Icons.error),
          ),
        );
      },
    );
  }
}