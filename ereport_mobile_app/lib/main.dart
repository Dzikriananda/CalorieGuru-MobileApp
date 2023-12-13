import 'package:ereport_mobile_app/src/core/constants/text_strings.dart';
import 'package:ereport_mobile_app/src/core/styles/app_theme.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/add_update_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/feedback_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/history_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/home_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/auth_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/profile_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/register_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/settings_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/splash_screen_viewmodel.dart';
import 'package:ereport_mobile_app/src/data/viewmodel/system_viewmodel.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/auth/auth_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/onboarding/onboarding_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/register/preregister_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/auth/screens/splash_screen/splash_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/bottom_navigation.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/about_app/about_app_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/about_app/webview_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/faq/faq_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/main/screens/settings/feedback/feedback_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/delete_account/delete_account_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/edit_authentication_screen/edit_authentication_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/edit_authentication_screen/select_authentication_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/edit_authentication_screen/enter_authentication_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/profile/screens/profile_screen/profile_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/transaction/screens/add_update/add_update_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/transaction/screens/burned_calorie_detail/burned_calorie_detail_screen.dart';
import 'package:ereport_mobile_app/src/presentations/modules/transaction/screens/calorie_detail/calorie_detail_screen.dart';
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
        ChangeNotifierProvider<HistoryViewModel>(create: (context) => HistoryViewModel(),lazy: false),
        ChangeNotifierProvider<SystemViewModel>(create: (context) => SystemViewModel()),
        ChangeNotifierProvider<ProfileViewModel>(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider<FeedBackViewModel>(create: (context) => FeedBackViewModel(),lazy: false),
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
          '/burnedCalorieDetailScreen': (context) => BurnedCalorieDetailScreen(),
          '/profileScreen': (context) => ProfileScreen(),
          '/enterAuthenticationScreen': (context) => EnterAuthenticationScreen(),
          '/selectEditAuthenticationScreen': (context) => SelectEditAuthenticationScreen(),
          '/editAuthenticationScreen': (context) => EditAuthenticationScreen(),
          '/faqScreen': (context) => FaqScreen(),
          '/feedbackScreen': (context) => FeedbackScreen(),
          '/aboutAppScreen': (context) => AboutAppScreen(),
          '/deleteAccountScreen': (context) => DeleteAccountScreen(),
          '/webViewScreen': (context) => WebViewScreen()
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
