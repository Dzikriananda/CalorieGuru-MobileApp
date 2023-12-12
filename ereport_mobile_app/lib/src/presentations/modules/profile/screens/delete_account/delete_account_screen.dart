import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        title: Text('Delete Account'),
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context,viewmodel,child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                        child: Image.asset(
                          'assets/images/sad.png',
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      Text('Are You Sure Want To Delete?',style: deleteAccountScreen_1),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        child: Text("We're Sorry To See You Go. Upon confirming the deletion of your account, you will be Logged Out and all personal dietary information, meal logs, and any progress tracked within the app will be permanently removed. This action is irreversible and will result in the complete erasure of your profile from the app's database. Please be aware that you will lose access to all features and benefits linked to this account. Are you sure you want to proceed with deleting your food diet account?",style: deleteAccountScreen_2,textAlign: TextAlign.justify,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await viewmodel.deleteAccount();
                                },
                                child: Text('Delete Account',style: TextStyle(color: onPrimaryColor)),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              )
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: Text('Keep Account',style: TextStyle(color: onPrimaryColor)),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Color(0XFF808080),
                                ),
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )

            ],
          );
        },
      )
    );
  }
}