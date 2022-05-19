import 'package:flutter/material.dart';

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
}
