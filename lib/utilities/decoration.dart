import 'package:flutter/material.dart';

BoxDecoration containerDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 6.0,
        offset: Offset(2, 2),
      ),
    ],
  );
}

BoxDecoration fieldDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 6.0,
        offset: Offset(2, 2),
      ),
    ],
  );
}
