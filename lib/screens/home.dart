import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namakala/widgets/screen_setting.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
        context: context,
        appBar: ScreenSetting.appBar(title: 'Home'),
        child: _category(title: 'Electronics')
    );
  }

  Widget _category({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.openSans(
                fontSize: 23.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    'All Items',
                    style: GoogleFonts.montserrat(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(Icons.navigate_next, size: 20.0,),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0,),
        SizedBox(
          height: 250.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(
                width: 250,
                child: Column(
                  children: [
                    const SizedBox(
                      width: 200,
                      height: 200,
                      child: FlutterLogo()),
                    Text(
                      'Mobiles',
                      style: GoogleFonts.nunito(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.red,
                width: 200,
              ),
              Container(
                color: Colors.yellow,
                width: 200,
              ),
            ],
          ),
        )
      ],
    );
  }
}
