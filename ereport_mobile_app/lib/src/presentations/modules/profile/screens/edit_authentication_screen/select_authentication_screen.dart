import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/text_strings.dart';
import '../../../../../core/styles/color.dart';
import '../../../../../core/styles/text_style.dart';

class SelectEditAuthenticationScreen extends StatefulWidget {
  const SelectEditAuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<SelectEditAuthenticationScreen> createState() => _SelectEditAuthenticationScreenState();
}

class _SelectEditAuthenticationScreenState extends State<SelectEditAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
        ),
        body: SafeArea(
            child: Consumer<SettingsViewModel>(
                builder: (context,viewmodel,child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              children: [
                                const Icon(Icons.admin_panel_settings_sharp,size: 100),
                                Text(TextStrings.selectAuthenticationScreen_1,style: petrolabTextTheme.titleLarge,textAlign: TextAlign.center),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/editAuthenticationScreen',arguments: true);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    height: MediaQuery.of(context).size.height * 0.08,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        ),
                                        color: primaryContainer
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                          Icon(Icons.lock,size: MediaQuery.of(context).size.height * 0.05),
                                          const Expanded(child: SizedBox()),
                                          Text(TextStrings.selectAuthenticationScreen_2,style: petrolabTextTheme.bodyLarge),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.05)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/editAuthenticationScreen',arguments: false);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    height: MediaQuery.of(context).size.height * 0.08,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        ),
                                        color: primaryContainer
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                          Icon(Icons.email,size: MediaQuery.of(context).size.height * 0.05),
                                          const Expanded(child: SizedBox()),
                                          Text(TextStrings.selectAuthenticationScreen_3,style: petrolabTextTheme.bodyLarge),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.05)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                              ],
                            ),
                          )
                      ),
                    ],
                  );
                }
            )
        )
    );
  }
}