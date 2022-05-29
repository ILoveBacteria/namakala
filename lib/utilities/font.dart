import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Font {
  static const double body1 = 14.0;
  static const double body2 = 12.0;
  static const double button = 12.0;
  static const double subtitle1 = 13.0;
  static const double subtitle2 = 12.0;
  static const double headline6 = 17.0;
  static const double headline5 = 20.0;

  static TextStyle styleHeadline1({Color? color}) {
    return GoogleFonts.openSans(
      fontSize: 95,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: color
    );
  }

  static TextStyle styleHeadline2({Color? color}) {
    return GoogleFonts.openSans(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: color
    );
  }

  static TextStyle styleHeadline3({Color? color}) {
    return GoogleFonts.openSans(
      fontSize: 59,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: color
    );
  }

  static TextStyle styleHeadline4({Color? color}) {
    return GoogleFonts.openSans(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: color
    );
  }

  static TextStyle styleHeadline5({Color? color}) {
    return GoogleFonts.openSans(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle styleHeadline6({Color? color}) {
    return GoogleFonts.openSans(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: color,
    );
  }

  static TextStyle styleSubtitle1({Color? color}) {
    return GoogleFonts.nunito(
      color: color,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    );
  }

  static TextStyle styleSubtitle2({Color? color}) {
    return GoogleFonts.nunito(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
    );
  }

  static TextStyle styleBody1({Color? color}) {
    return GoogleFonts.nunito(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: color,
    );
  }

  static TextStyle styleBody2({Color? color}) {
    return GoogleFonts.nunito(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: color,
    );
  }

  static TextStyle styleButton1({Color? color}) {
    return GoogleFonts.montserrat(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 1.25,
    );
  }

  static TextStyle styleButton2({Color? color}) {
    return GoogleFonts.montserrat(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0.25,
    );
  }

  static TextStyle styleOverline({Color? color}) {
    return GoogleFonts.nunito(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: color
    );
  }

  static TextStyle styleCaption({Color? color}) {
    return GoogleFonts.nunito(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      color: color
    );
  }
}
