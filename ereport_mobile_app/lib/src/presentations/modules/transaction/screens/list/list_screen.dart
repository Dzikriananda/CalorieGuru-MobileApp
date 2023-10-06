import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class ListScreenActivity extends StatefulWidget {

  ListScreenActivity({Key? key}) : super(key: key);

  @override
  State<ListScreenActivity> createState() => _ListScreenActivityState();
}

class _ListScreenActivityState extends State<ListScreenActivity> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
          title: Text('Transactions - $args', style: TextStyle(color: onPrimaryColor)),
          backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20,10,20,0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.88,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search Report',
                  filled: true,
                  fillColor: searchFieldColor
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: primaryContainer
                          ),
                          child: Column (
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                      child: Icon(
                                        Icons.water_drop_sharp,
                                        size: 50,
                                        color: goodResultColor
                                      ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text('PT Ambatukam',style: listItemText),
                                        width: MediaQuery.of(context).size.width * 0.7,
                                      ),
                                      Text('M123456 (CRITICAL)',style: listItemText),
                                    ],
                                  )
                                ],
                              ),
                              Align(
                                alignment : Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Unit No : LT001',style: listItemText),
                                      Text('Component : Bearing',style: listItemText),
                                      Text('Sample : Dec 9, 2023',style: listItemText),
                                    ],
                                  ),
                                )
                              ),
                              Align(
                                alignment : Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  child: Text('Report : Jan 1, 2024',style: listItemText),
                                ),
                              )
                            ],
                          )
                        )
                      );
                    }
                ),
            )
          ],
        )
      )

    );
  }
}