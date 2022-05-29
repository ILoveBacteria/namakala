import 'package:flutter/material.dart';
import 'package:namakala/utilities/font.dart';

class Button {
  static elevatedIcon({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPress
  }) {
    return ElevatedButton.icon(
      onPressed: onPress,
      icon: Icon(
        icon,
        color: Colors.white,
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
    required VoidCallback onPress
  }) {
    return ElevatedButton(
      onPressed: onPress,
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
    required VoidCallback onPress
  }) {
    return OutlinedButton(
      onPressed: onPress,
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
        onPress: onPressed);
  }

  static signIn({required VoidCallback onPressed}) {
    return elevatedIcon(
        icon: Icons.login_outlined,
        label: 'SIGN IN',
        color: Colors.green,
        onPress: onPressed);
  }

  static signUp({required VoidCallback onPressed}) {
    return elevated(
        text: 'SIGN UP',
        color: Colors.blueAccent,
        onPress: onPressed);
  }

  static SizedBox separate() {
    return const SizedBox(height: 40.0);
  }
}