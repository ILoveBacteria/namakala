import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/decoration.dart';
import 'field.dart';

class ScreenSetting {
  static initSignInAndUp({required Widget child, required BuildContext context}) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0),
            child: child
          ),
        )
      )
    );
  }

  static buildTitleText(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
      )
    );
  }

  static fieldsContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: containerDecoration(),
      child: child
    );
  }

  static buildEmailField() {
    return Field.container(
      TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: Field.hintStyle(),
          border: Field.border(),
          prefixIcon: const Icon(Icons.mail_outline),
        ),
      )
    );
  }

  static buildPasswordField() {
    return Field.container(
      TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: Field.hintStyle(),
          border: Field.border(),
          prefixIcon: const Icon(Icons.password_outlined),
        ),
      )
    );
  }

  static buildPasswordConfirmField() {
    return Field.container(
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            hintStyle: Field.hintStyle(),
            border: Field.border(),
            prefixIcon: const Icon(Icons.password_outlined),
          ),
        )
    );
  }

  static buildFirstNameField() {
    return Field.container(
      TextField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: 'First Name',
          hintStyle: Field.hintStyle(),
          border: Field.border(),
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
      )
    );
  }

  static buildLastNameField() {
    return Field.container(
      TextField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: 'Last Name',
          hintStyle: Field.hintStyle(),
          border: Field.border(),
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
      )
    );
  }

  static buildPhoneField() {
    return Field.container(
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Phone',
            hintStyle: Field.hintStyle(),
            border: Field.border(),
            prefixIcon: const Icon(Icons.call_outlined),
          ),
        )
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
}
