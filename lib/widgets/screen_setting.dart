import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSetting {
  static initSignInAndUp({required Widget child, required BuildContext context}) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: initScreen(child: child, context: context)
    );
  }

  static initScreen({required Widget child, required BuildContext context}) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0
          ),
          child: child
        ),
      )
    );
  }

  static buildTitleText(String text) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.openSans(
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          )
        ),
        const SizedBox(height: 30.0)
      ],
    );
  }





  static buildSubmitButton(String text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            letterSpacing: 2.0
          )
        ),
      ),
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
