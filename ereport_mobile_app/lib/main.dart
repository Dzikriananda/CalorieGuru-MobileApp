import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/app_theme.dart';
import 'package:ereport_mobile_app/src/core/utils/connection_checker.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/home_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/splash_screen_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/signin/signin_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/splash_screen/splash_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/bottom_navigation.dart';
import 'package:ereport_mobile_app/src/presentations/modules/transaction/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //InternetConnectionManager().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SplashScreenViewModel>(create: (context) => SplashScreenViewModel()),
        ChangeNotifierProvider<HomeViewModel>(create: (context) => HomeViewModel(),lazy: false),
      ],
      child: MaterialApp(
        title: TextStrings.appTitle,
        theme: AppTheme.lightTheme(context),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/bottomNavigation' : (context) => const BottomNavigation(),
          '/listScreen' : (context) => ListScreenActivity(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == "/loginScreen") {
            return PageRouteBuilder(
                settings: settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (_, __, ___) => SignInScreen(),
                transitionDuration: Duration(seconds: 2)
            );
          }
          // Unknown route
        },
      ),
    );
  }
}
