import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSetting {
  static EdgeInsets _screenPadding() {
    return const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0);
  }

  static initSignInAndUp({
    required Widget child,
    required BuildContext context,
    required var appBar}) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: initScreen(child: child, context: context, appBar: appBar)
    );
  }

  static initScreen({
    required BuildContext context,
    required AppBar appBar,
    required Widget child,
  }) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: _screenPadding(),
          child: child
        ),
      )
    );
  }

  static initScreenWithSliverBar({
    required Widget child,
    required BuildContext context,
    required SliverAppBar appBar}) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          appBar,
          SliverToBoxAdapter(
            child: Padding(
              padding: _screenPadding(),
              child: child
            ),
          ),
        ],
      )
    );
  }

  static appBar({required String title}) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.openSans(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: Colors.black
        )
      ),
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)
        )
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  static sliverAppBar({String? title, required BuildContext context}) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 5.0,
      expandedHeight: MediaQuery.of(context).size.width * 70 / 100,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
        color: Colors.blue,
      ),
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        background: const FlutterLogo(),
        title: title == null ? null : Text(
          title,
          style: GoogleFonts.openSans(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            color: Colors.black
          )
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0)
        )
      ),
    );
  }

  static buildDetailTextAndButton({required String text, required String buttonText, required VoidCallback? onPressed}) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontSize: 13.0,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: GoogleFonts.montserrat(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            )
          ),
        ),
      ],
    );
  }
}
