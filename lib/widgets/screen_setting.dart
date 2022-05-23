import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSetting {
  static initSignInAndUp({
    required Widget child,
    required BuildContext context,
    required var appBar}) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: initScreen(child: child, context: context, appBar: appBar)
    );
  }

  static initScreen({
    required Widget child,
    required BuildContext context,
    required var appBar}) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0
          ),
          child: child
        ),
      )
    );
  }

  static appBar({required String title}) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.openSans(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: Colors.black
        )
      ),
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)
        )
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  static buildDetailTextAndButton({required String text, required String buttonText, required VoidCallback? onPressed}) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontSize: 13.0,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: GoogleFonts.montserrat(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            )
          ),
        ),
      ],
    );
  }
}
