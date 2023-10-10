import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/app_theme.dart';
import 'package:ereport_mobile_app/src/core/utils/connection_checker.dart';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/home_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/login_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/splash_screen_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/register_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/signin/signin_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/splash_screen/splash_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/bottom_navigation.dart';
import 'package:ereport_mobile_app/src/presentations/modules/transaction/screens/list/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth = Auth();
  auth.authStateChanges.listen((event) {print("status di main : $event");});
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
        ChangeNotifierProvider<SplashScreenViewModel>(create: (context) => SplashScreenViewModel(),lazy: false),
        ChangeNotifierProvider<HomeViewModel>(create: (context) => HomeViewModel(),lazy: false),
        ChangeNotifierProvider<LoginViewModel>(create: (context) => LoginViewModel()),
        ChangeNotifierProvider<SettingsViewModel>(create: (context) => SettingsViewModel(),lazy: false),

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
          '/registerScreen' : (context) => RegisterScreen(),
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
