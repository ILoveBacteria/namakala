import 'package:flutter/material.dart';
import 'package:namakala/screens/add_product.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/font.dart';

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
      child: _buildEmptyMarketScreen(context),
    );
  }

  Widget _buildEmptyMarketScreen(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.store_outlined,
              size: 100.0,
              color: Color.fromARGB(255, 179, 179, 179),
            ),
            Text(
              'You don\'t have any products yet',
              style: Font.styleBody1(
                  color: const Color.fromARGB(255, 179, 179, 179)),
            ),
          ],
        ),
      ),
    );
  }
}
