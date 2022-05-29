import 'package:flutter/material.dart';
import 'package:namakala/utilities/font.dart';

class Button {
  static elevatedIcon({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 20.0,
      ),
      label: Text(
        label,
        style: Font.styleButton1()
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        primary: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
        )
      ),
    );
  }

  static elevated({
    required String text,
    required Color color,
    required VoidCallback onPressed
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Font.styleButton1()
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        primary: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
        )
      ),
    );
  }

  static outlined({
    required String text,
    required Color color,
    required VoidCallback onPressed
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Font.styleButton1(color: color)
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        primary: color,
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
        )
      ),
    );
  }

  static raw({VoidCallback? onPressed, required Widget child}) {
    return RawMaterialButton(
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }

  static signOut({required VoidCallback onPressed}) {
    return elevatedIcon(
        icon: Icons.logout_outlined,
        label: 'SIGN OUT',
        color: Colors.redAccent,
        onPressed: onPressed);
  }

  static signIn({required VoidCallback onPressed}) {
    return elevatedIcon(
        icon: Icons.login_outlined,
        label: 'SIGN IN',
        color: Colors.green,
        onPressed: onPressed);
  }

  static signUp({required VoidCallback onPressed}) {
    return elevated(
        text: 'SIGN UP',
        color: Colors.blueAccent,
        onPressed: onPressed);
  }

  static SizedBox separate() {
    return const SizedBox(height: 40.0);
  }
}