import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            letterSpacing: 2.0
        )
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
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          letterSpacing: 2.0
        )
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

  static signOut({required VoidCallback onPress}) {
    return elevatedIcon(
        icon: Icons.logout_outlined,
        label: 'SIGN OUT',
        color: Colors.redAccent,
        onPress: onPress);
  }

  static signIn({required VoidCallback onPress}) {
    return elevatedIcon(
        icon: Icons.login_outlined,
        label: 'SIGN IN',
        color: Colors.green,
        onPress: onPress);
  }

  static signUp({required VoidCallback onPress}) {
    return elevated(
        text: 'SIGN UP',
        color: Colors.blueAccent,
        onPress: onPress);
  }

  static SizedBox separate() {
    return const SizedBox(height: 40.0);
  }
}