import 'package:flutter/material.dart';
import 'package:namakala/utilities/font.dart';
import '../utilities/decoration.dart';

class Field {
  static hintStyle() {
    return Font.styleBody2(color: Colors.black26);
  }

  static border() {
    return InputBorder.none;
  }

  static SizedBox separate() {
    return const SizedBox(height: 30);
  }

  static Widget container(Widget child) {
    return Container(
        height: 50.0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 3.0),
        decoration: fieldDecoration(),
        child: child
    );
  }

  static Widget field({String? initialValue, required String label, TextInputType? keyboardType, String? hintText, IconData? prefixIcon, IconData? suffixIcon, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Field.label(label: label),
        const SizedBox(height: 5.0),
        Field.container(
          TextFormField(
            initialValue: initialValue,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Field.hintStyle(),
              border: Field.border(),
              prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
              suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
            ),
          )
        ),
      ],
    );
  }

  static Widget email({String? initialValue}) {
    return Field.field(label: 'Email', initialValue: initialValue, keyboardType: TextInputType.emailAddress, hintText: 'example@mail.com', prefixIcon: Icons.mail_outline,);
  }

  static Widget password({String? initialValue}) {
    return Field.field(label: 'Password', initialValue: initialValue, obscureText: true, hintText: 'Contains A-z and 0-9', prefixIcon: Icons.password_outlined,);
  }

  static Widget passwordConfirm({String? initialValue}) {
    return Field.field(label: 'Confirm Password', initialValue: initialValue, obscureText: true, hintText: 'Contains A-z and 0-9', prefixIcon: Icons.password_outlined,);
  }

  static Widget firstName({String? initialValue}) {
    return Field.field(label: 'First Name', initialValue: initialValue, keyboardType: TextInputType.name, hintText: 'Lionel', prefixIcon: Icons.badge_outlined,);
  }

  static Widget lastName({String? initialValue}) {
    return Field.field(label: 'Last Name', initialValue: initialValue, keyboardType: TextInputType.name, hintText: 'Messi', prefixIcon: Icons.badge_outlined,);
  }

  static Widget phone({String? initialValue}) {
    return Field.field(label: 'Phone', initialValue: initialValue, keyboardType: TextInputType.phone, hintText: '+989123456789', prefixIcon: Icons.call_outlined,);
  }

  static Widget parentContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: containerDecoration1(),
      child: child
    );
  }

  static Text label({required String label}) {
    return Text(
      label,
      style: Font.styleSubtitle2(color: Colors.grey),
    );
  }
}