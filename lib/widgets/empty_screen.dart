import 'package:flutter/material.dart';

import '../utilities/font.dart';

class EmptyScreen {
  final IconData _icon;
  final String _text;

  EmptyScreen(this._icon, this._text);

  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              _icon,
              size: 100.0,
              color: const Color.fromARGB(255, 179, 179, 179),
            ),
            Text(
              _text,
              style: Font.styleBody1(
                  color: const Color.fromARGB(255, 179, 179, 179)),
            ),
          ],
        ),
      ),
    );
  }
}