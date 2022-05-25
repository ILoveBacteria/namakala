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

  static separate() {
    return const SizedBox(height: 30);
  }

  static container(Widget child) {
    return Container(
        height: 60.0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 3.0),
        decoration: fieldDecoration(),
        child: child
    );
  }

  static email() {
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

  static password() {
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

  static passwordConfirm() {
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

  static firstName() {
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

  static lastName() {
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

  static phone() {
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

  static parentContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: containerDecoration(),
      child: child
    );
  }
}