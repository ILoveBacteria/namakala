import 'dart:ui';

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
      child: Column(
        children: [
          _category(
            title: 'Electronics',
            items: <Widget>[
              _items(image: 'assets/images/iphone.png', title: 'Mobiles'),
              const VerticalDivider(color: Colors.grey),
              _items(image: 'assets/images/macbook.png', title: 'Laptops'),
              const VerticalDivider(color: Colors.grey),
              _items(image: 'assets/images/camera.png', title: 'Camera'),
              const VerticalDivider(color: Colors.grey),
              _items(image: 'assets/images/ipad.png', title: 'Tablets'),
            ],
          ),
        ],
      )
    );
  }

  Widget _category({required String title, required List<Widget> items}) {
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
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: items
          ),
        )
      ],
    );
  }

  Widget _items({required String image, required String title}) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      width: 200.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 140.0,
          ),
          SizedBox(
            height: 48.0,
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
