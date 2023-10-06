import 'package:ereport_mobile_app/src/core/classes/icons.dart';
import 'package:ereport_mobile_app/src/core/constants/result_state.dart';
import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:ereport_mobile_app/src/data/data_source/local/icon_data.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/home_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/global_widgets/alert_dialog.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/grid_view_builder.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/home/widgets/list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  ScrollController scrollController = ScrollController();
  List<CustomIcon> reportIcon = icons;
  bool showAlert = false;

  List<String> image = [
    'https://disk.mediaindonesia.com/thumbs/1800x1200/news/2022/11/de3a94b12c4f87ca3b3a66dff43ea07d.jpg',
    'https://news.unair.ac.id/wp-content/uploads/2019/09/Ilustrasi-oleh-fmipaunj.jpg',
    'https://d1bpj0tv6vfxyp.cloudfront.net/articles/27788_30-3-2021_23-25-59.jpeg',
  ];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      context.read<HomeViewModel>().checkNetwork();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().checkNetwork();
    });
  }

  bool _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;


  @override
  void dispose() {
    scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InternetAlertDialog(
            onRetry: (){
              context.read<HomeViewModel>().checkNetwork();
              Navigator.of(context).pop(); // Close the dialog./ Close the dialog.
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var status = context.watch<HomeViewModel>().state;
    if(status == ResultState.noConnection){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bool isShow = _isThereCurrentDialogShowing(context);
        if(!isShow){
          _showAlertDialog(context);
        }
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent/2);
    });
    return AnnotatedRegion(
        child: Scaffold(
            body: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(48), // Image radius
                                    child: Image.network('https://www.w3schools.com/howto/img_avatar.png', fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Dzikri Ananda Fernando",
                                          style: petrolabTextTheme.titleLarge,
                                        ),
                                        width: MediaQuery. of(context). size. width * 0.6,
                                      ),
                                      Container(
                                        child: Text(
                                          "Petrolab Cabang Balikpapan",
                                          style: petrolabTextTheme.titleMedium,
                                        ),
                                        width: MediaQuery. of(context). size. width * 0.6,
                                      ),
                                      Container(
                                        child: Text(
                                          "IoT Engineer & Programmer",
                                          style: petrolabTextTheme.bodyMedium,
                                        ),
                                        width: MediaQuery. of(context). size. width * 0.6,
                                      ),
                                    ]
                                ),
                              ],
                            )
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: MediaQuery. of(context). size. width * 0.4,
                        child: ListViewBuilder(scrollController: scrollController,image: image),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(25, 20, 20, 10),
                            child: Text(
                                "Report",
                                style: homeScreenReportText
                            ),
                          )
                      ),
                      Expanded(
                          child: GridViewBuilder(
                            icons: reportIcon,
                          )
                      ),
                    ],
                  ),
                  Visibility(
                    visible: (status == ResultState.loading),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                ],
              )
            )
        ),
        value: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
    );
  }

}









