import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/decoration.dart';

class Field {
  static hintStyle() {
    return GoogleFonts.nunito(
      color: Colors.black26,
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
        height: 55.0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 3.0),
        decoration: fieldDecoration(),
        child: child
    );
  }

  static email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Email'),
        Field.container(
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'example@mail.com',
              hintStyle: Field.hintStyle(),
              border: Field.border(),
              prefixIcon: const Icon(Icons.mail_outline),
            ),
          )
        ),
      ],
    );
  }

  static password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Password'),
        Field.container(
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Contains A-z and 0-9',
              hintStyle: Field.hintStyle(),
              border: Field.border(),
              prefixIcon: const Icon(Icons.password_outlined),
            ),
          )
        ),
      ],
    );
  }

  static passwordConfirm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Confirm Password'),
        Field.container(
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Contains A-z and 0-9',
              hintStyle: Field.hintStyle(),
              border: Field.border(),
              prefixIcon: const Icon(Icons.password_outlined),
            ),
          )
        ),
      ],
    );
  }

  static firstName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'First Name'),
        Field.container(
          TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'Lionel',
              hintStyle: Field.hintStyle(),
              border: Field.border(),
              prefixIcon: const Icon(Icons.badge_outlined),
            ),
          )
        ),
      ],
    );
  }

  static lastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Last Name'),
        Field.container(
          TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'Messi',
              hintStyle: Field.hintStyle(),
              border: Field.border(),
              prefixIcon: const Icon(Icons.badge_outlined),
            ),
          )
        ),
      ],
    );
  }

  static phone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Phone'),
        Field.container(
          TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '+989120284896',
              hintStyle: Field.hintStyle(),
              border: Field.border(),
              prefixIcon: const Icon(Icons.call_outlined),
            ),
          )
        ),
      ],
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

  static Text label({required String label}) {
    return Text(
      label,
      style: GoogleFonts.nunito(
        color: Colors.grey,
        fontSize: 17.0,
        fontWeight: FontWeight.w700
      ),
    );
  }
}