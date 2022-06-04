import 'package:flutter/material.dart';

import '../utilities/font.dart';

class SnackMessage {
  final String message;

  SnackMessage(this.message);

  void build(BuildContext context) {
    final snackBar = SnackBar(
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Text(
        message,
        style: Font.styleBody1(),
      ),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
