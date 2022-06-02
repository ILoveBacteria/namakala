import 'package:flutter/material.dart';
import 'package:namakala/screens/add_product.dart';
import 'package:namakala/widgets/screen_setting.dart';

class MyMarket extends StatelessWidget {
  const MyMarket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(
        title: 'My Market',
        context: context,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddProduct()),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      child: Container(),
    );
  }
}
