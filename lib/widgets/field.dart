import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/decoration.dart';

class Field {
  static hintStyle() {
    return GoogleFonts.nunito(
      color: Colors.black38,
    );
  }

  static border() {
    return InputBorder.none;
  }

  static container(Widget child) {
    return Container(
        height: 60.0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10.0),
        decoration: fieldDecoration(),
        child: child
    );
  }
}