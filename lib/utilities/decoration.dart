import 'package:flutter/material.dart';

BoxDecoration containerDecoration1() {
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

BoxDecoration containerDecoration2() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.black12, width: 1.3),
  );
}

BoxDecoration fieldDecorationUnSelected({Color? borderColor}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: borderColor ?? Colors.black12, width: 1.3),
  );
}

BoxDecoration fieldDecorationSelected() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 6.0,
        offset: Offset(2, 2),
      ),
    ],
  );
}
