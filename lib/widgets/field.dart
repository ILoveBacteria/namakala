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

  static Widget container({
    required Widget child,
    Color? borderColor,
    double height = 50.0,
    double leftPadding = 0.0,
    bool selected = false,
  }) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: leftPadding, right: 10.0),
      decoration: selected
          ? fieldDecorationSelected()
          : fieldDecorationUnSelected(borderColor: borderColor),
      child: child,
    );
  }

  static Widget field({
    String? initialValue,
    required String label,
    TextInputType? keyboardType,
    String? hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    FocusNode? focusNode,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    Widget? suffixButton,
    FieldStatus status = FieldStatus.none,
    bool obscureText = false,
    int maxLines = 1,
    double height = 50.0,
    bool selected = false,
  }) {
    var stackChildren = <Widget>[
      Field.container(
        leftPadding: prefixIcon == null ? 10.0 : 0.0,
        height: height,
        borderColor: status == FieldStatus.none
            ? null
            : (status == FieldStatus.validate ? Colors.green : Colors.red),
        selected: focusNode == null ? selected : focusNode.hasFocus,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          onTap: onTap,
          maxLines: maxLines,
          initialValue: initialValue,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Field.hintStyle(),
            border: Field.border(),
            prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
            suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
            prefixIconColor: status == FieldStatus.none
                ? null
                : (status == FieldStatus.validate ? Colors.green : Colors.red),
          ),
        ),
      ),
    ];

    if (suffixButton != null) {
      stackChildren.add(
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: suffixButton,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Field.label(
          label: label,
          color: status == FieldStatus.none
              ? null
              : (status == FieldStatus.validate ? Colors.green : Colors.red),
        ),
        const SizedBox(height: 5.0),
        Stack(
          children: stackChildren,
        ),
      ],
    );
  }

  static Widget email({
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    FieldStatus status = FieldStatus.none,
  }) {
    return Field.field(
      label: 'Email',
      initialValue: initialValue,
      keyboardType: TextInputType.emailAddress,
      hintText: 'example@mail.com',
      prefixIcon: Icons.mail_outline,
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      status: status,
    );
  }

  static Widget password({
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    Widget? suffixButton,
    FieldStatus status = FieldStatus.none,
    bool obscureText = true,
  }) {
    return Field.field(
      label: 'Password',
      initialValue: initialValue,
      obscureText: obscureText,
      suffixButton: suffixButton,
      hintText: 'Contains at least 8 characters',
      prefixIcon: Icons.password_outlined,
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      status: status,
    );
  }

  static Widget passwordConfirm({
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    Widget? suffixButton,
    FieldStatus status = FieldStatus.none,
    bool obscureText = true,
  }) {
    return Field.field(
      label: 'Confirm Password',
      initialValue: initialValue,
      obscureText: obscureText,
      suffixButton: suffixButton,
      hintText: 'Contains at least 8 characters',
      prefixIcon: Icons.password_outlined,
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      status: status,
    );
  }

  static Widget firstName({
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    FieldStatus status = FieldStatus.none,
  }) {
    return Field.field(
      label: 'First Name',
      initialValue: initialValue,
      keyboardType: TextInputType.name,
      hintText: 'Lionel',
      prefixIcon: Icons.badge_outlined,
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      status: status,
    );
  }

  static Widget lastName({
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    FieldStatus status = FieldStatus.none,
  }) {
    return Field.field(
      label: 'Last Name',
      initialValue: initialValue,
      keyboardType: TextInputType.name,
      hintText: 'Messi',
      prefixIcon: Icons.badge_outlined,
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      status: status,
    );
  }

  static Widget phone({
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    FieldStatus status = FieldStatus.none,
  }) {
    return Field.field(
      label: 'Phone',
      initialValue: initialValue,
      keyboardType: TextInputType.phone,
      hintText: '09123456789',
      prefixIcon: Icons.call_outlined,
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      status: status,
    );
  }

  static bool emailValidate(String? value) {
    if (value == null ||
        !RegExp(r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""")
            .hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool nameValidate(String? value) {
    if (value == null ||
        !RegExp(r"^[A-Za-z .]*$").hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool marketValidate(String? value) {
    if (value == null ||
        !RegExp(r'^[a-zA-Z0-9-() ]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool phoneValidate(String? value) {
    if (value == null ||
        !RegExp(r'^(09\d{9})|(\+989\d{9})$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  static bool passwordValidate(String? value) {
    if (value == null || value.length < 8) {
      return false;
    }
    return true;
  }

  static Widget parentContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: containerDecoration1(),
      child: child,
    );
  }

  static Text label({required String label, Color? color}) {
    return Text(
      label,
      style: Font.styleSubtitle2(color: color ?? Colors.grey),
    );
  }
}

enum FieldStatus { error, validate, none }
