import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      textTheme: petrolabTextTheme,
      colorScheme: Theme.of(context).colorScheme.copyWith(
           primary: primaryColor,
           onPrimary: onPrimaryColor,
           secondary: secondaryColor,
           onSecondary: onSecondaryColor,
           background: backgroundColor,
           onBackground: onBackgroundColor,
           primaryContainer: primaryContainer,
           onPrimaryContainer: onPrimaryContainer,
      )
      //     colorScheme: lightColorScheme,
      //     fontFamily: 'Poppins',
      //     useMaterial3: true,
      //     scaffoldBackgroundColor: ConstColors.whiteColor,
      //     inputDecorationTheme: CustomTextFieldTheme.inputDecorationTheme,
      //     textTheme: Theme.of(context).textTheme.apply(
      //           bodyColor: Colors.black,
      //           displayColor: Colors.black,
      //           fontFamily: 'Poppins',
      //           // fontSizeFactor: 12,
      //         ));

      // static const lightColorScheme = ColorScheme(
      //   brightness: Brightness.light,
      //   primary: ConstColors.primaryColor,
      //   onPrimary: ConstColors.primaryColor,
      //   secondary: ConstColors.secondaryColor,
      //   onSecondary: ConstColors.secondaryColor,
      //   error: ConstColors.redColor,
      //   onError: ConstColors.redColor,
      //   background: ConstColors.whiteColor,
      //   onBackground: ConstColors.whiteColor,
      //   surface: ConstColors.greyColor,
      //   onSurface: ConstColors.greyColor,
      );
}
