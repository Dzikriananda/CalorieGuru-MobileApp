import 'package:ereport_mobile_app/src/core/constants/images.dart';
import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/about_app/widgets/aboutAppPadding.dart';
import 'package:flutter/material.dart';


class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: borderColor_4,
              height: 2,
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: MediaQuery.of(context).size.height * 0.04),
                  child: Image.asset(
                    DefaultImages.logo,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
              ),
              AboutAppPadding(
                widget: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(TextStrings.aboutAppScreen_1,style: aboutAppScreen_1),
                ),
              ),
              AboutAppPadding(
                widget: const Text(TextStrings.aboutAppScreen_2,style: aboutAppScreen_2,textAlign: TextAlign.justify),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AboutAppPadding(
                  widget: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/webViewScreen');
                          },
                          child: Text(TextStrings.aboutAppScreen_3,style: TextStyle(color: onPrimaryColor)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: primaryColor,
                          ),
                        )
                    ),
                  )
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AboutAppPadding(
                widget: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(TextStrings.aboutAppScreen_4,style: aboutAppScreen_1),
                ),
              ),
              AboutAppPadding(
                widget: Text(TextStrings.aboutAppScreen_5,style: aboutAppScreen_2,textAlign: TextAlign.justify),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AboutAppPadding(
                  widget: Text(TextStrings.aboutAppScreen_6,style: aboutAppScreen_2,textAlign: TextAlign.justify)
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AboutAppPadding(
                  widget: Text(TextStrings.aboutAppScreen_7,style: aboutAppScreen_2,textAlign: TextAlign.justify)
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AboutAppPadding(
                  widget: Text(TextStrings.aboutAppScreen_8,style: aboutAppScreen_2,textAlign: TextAlign.justify)
              )
            ],
          ),
        ),
      )
    );
  }
}