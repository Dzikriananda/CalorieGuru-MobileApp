import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final petrolabTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 93,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
  ),
  displayMedium: GoogleFonts.poppins(
      fontSize: 58,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5
  ),
  displaySmall: GoogleFonts.poppins(
      fontSize: 47,
      fontWeight: FontWeight.w400,

  ),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 33,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: onBackgroundColor,
  ),
  headlineSmall: GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.w400
  ),
  titleLarge: GoogleFonts.poppins(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15
  ),
  titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15
  ),
  titleSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1
  ),
  bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5
  ),
  bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25
  ),
  labelLarge: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25
  ),
  bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4
  ),
  labelSmall: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5
  ),
);

const TextStyle listItemText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: onPrimaryContainer,
    letterSpacing: 0,
    decoration: TextDecoration.none
);

const TextStyle registerOptionText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: onBackgroundColor,
    letterSpacing: 0,
    decoration: TextDecoration.none
);

const TextStyle containerOptionText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: onPrimaryContainer,
    letterSpacing: 0,
    decoration: TextDecoration.none
);

const TextStyle homeScreenReportText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 25,
    fontWeight: FontWeight.w900,
    color: onBackgroundColor,
    letterSpacing: 0,
    decoration: TextDecoration.none
);

const TextStyle splashScreenText = TextStyle(
 fontFamily: 'Poppins',
 fontSize: 25,
 fontWeight: FontWeight.w600,
 color: onBackgroundColor,
 letterSpacing: 0,
 decoration: TextDecoration.none
);

const TextStyle nameScreenText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: onBackgroundColor,
    letterSpacing: 0,
    decoration: TextDecoration.none
);

const TextStyle LoginButtonText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: onPrimaryColor,
    letterSpacing: 0,
    decoration: TextDecoration.none
);

const TextStyle LoginScreenText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 35,
    fontWeight: FontWeight.w900,
    color: onPrimaryContainer,
    letterSpacing: 0,
    decoration: TextDecoration.none
);