import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/app_theme.dart';
import 'package:ereport_mobile_app/src/data/auth/auth.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/add_update_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/home_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/auth_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/register_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/splash_screen_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/auth/auth_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/onboarding_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/preregister_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/splash_screen/splash_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/bottom_navigation.dart';
import 'package:ereport_mobile_app/src/presentations/modules/transaction/screens/add_update/list_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/transaction/screens/calorie_detail/calorie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:ereport_mobile_app/src/data/data_source/remote/api_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final auth = Auth();
  // // auth.authStateChanges.listen((event) {print("status di main : $event");});
  // // //InternetConnectionManager().init();
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
        ChangeNotifierProvider<AuthViewModel>(create: (context) => AuthViewModel()),
        ChangeNotifierProvider<SettingsViewModel>(create: (context) => SettingsViewModel(),lazy: false),
        ChangeNotifierProvider<RegisterViewModel>(create: (context) => RegisterViewModel(),lazy: false),
        ChangeNotifierProvider<AddUpdateViewModel>(create: (context) => AddUpdateViewModel(),lazy: false),

      ],
      child: MaterialApp(
        title: TextStrings.appTitle,
        theme: AppTheme.lightTheme(context),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/bottomNavigation' : (context) => const BottomNavigation(),
          '/listScreen' : (context) => AddUpdateScreen(),
          '/registerScreen' : (context) => PreRegisterScreen(),
          '/calorieDetailScreen': (context) => CalorieDetailScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == "/authScreen") {
            return PageRouteBuilder(
                settings: settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (_, __, ___) => AuthScreen(),
                transitionDuration: Duration(seconds: 2)
            );
          }
          if (settings.name == "/onBoardingScreen") {
            return PageRouteBuilder(
                settings: settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (_, __, ___) => OnBoardingScreen(),
                transitionDuration: Duration(seconds: 2)
            );
          }
          // Unknown route
        },
      ),
    );
  }
}
