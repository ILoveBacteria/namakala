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

  static separate() {
    return const SizedBox(height: 30);
  }

  static container(Widget child) {
    return Container(
        height: 50.0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 3.0),
        decoration: fieldDecoration(),
        child: child
    );
  }

  static email({String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Email'),
        const SizedBox(height: 5.0),
        Field.container(
          TextFormField(
            initialValue: initialValue,
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

  static password({String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Password'),
        const SizedBox(height: 5.0),
        Field.container(
          TextFormField(
            initialValue: initialValue,
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

  static passwordConfirm({String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Confirm Password'),
        const SizedBox(height: 5.0),
        Field.container(
          TextFormField(
            initialValue: initialValue,
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

  static firstName({String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'First Name'),
        const SizedBox(height: 5.0),
        Field.container(
          TextFormField(
            initialValue: initialValue,
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

  static lastName({String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Last Name'),
        const SizedBox(height: 5.0),
        Field.container(
          TextFormField(
            initialValue: initialValue,
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

  static phone({String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: 'Phone'),
        const SizedBox(height: 5.0),
        Field.container(
          TextFormField(
            initialValue: initialValue,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '+989123456789',
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
      style: Font.styleSubtitle2(color: Colors.grey),
    );
  }
}