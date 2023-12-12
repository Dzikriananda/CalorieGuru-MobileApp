import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/faq/widgets/faq_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:ereport_mobile_app/src/data/models/faq_model.dart';
import 'package:ereport_mobile_app/src/data/data_source/local/faq_data.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  late List<FaqItem> list;

  @override
  void initState() {
    super.initState();
    list = faqs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: backgroundColor,
        title: Text(TextStrings.faqScreen_1),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) =>
                FaqItemWidget(item: list[index]),
            ),
          ),
        ],
      )
    );
  }
}

