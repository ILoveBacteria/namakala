import 'package:flutter/material.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/product.dart';

class MobileCategory extends StatelessWidget {
  const MobileCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: 'Mobile', context: context),
      child: _product(null)
    );
  }

  Widget _product(Product? product) {
    return SizedBox(
      height: 150.0,
      child: Row(
        children: [
          Image.asset('assets/images/iphone.png'),
          Column(
            children: [
              Text(
                'iPhone 13 pro max',
                style: Font.styleSubtitle1(),
              ),
              Text(
                '999\$',
                style: Font.styleBody1(),
              )
            ],
          )
        ],
      ),
    );
  }
}
