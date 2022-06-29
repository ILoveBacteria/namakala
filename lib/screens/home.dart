import 'package:flutter/material.dart';
import 'package:namakala/screens/product_category.dart';
import 'package:namakala/utilities/arguments.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/screen_setting.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: 'Home'),
      child: Column(
        children: <Widget>[
          _category(
            title: 'Electronics',
            items: <Widget>[
              _items(
                  image: 'assets/images/iphone.png',
                  title: 'Mobiles',
                  context: context),
              const VerticalDivider(color: Colors.grey),
              _items(
                  image: 'assets/images/macbook.png',
                  title: 'Laptops',
                  context: context),
              const VerticalDivider(color: Colors.grey),
              _items(
                  image: 'assets/images/camera.png',
                  title: 'Camera',
                  context: context),
              const VerticalDivider(color: Colors.grey),
              _items(
                  image: 'assets/images/ipad.png',
                  title: 'Tablets',
                  context: context),
            ],
          ),
          categorySeparator(),
          _category(
            title: 'Clothing',
            items: <Widget>[
              _items(
                  image: 'assets/images/men.png',
                  title: 'Men',
                  context: context),
              const VerticalDivider(color: Colors.grey),
              _items(
                  image: 'assets/images/women.png',
                  title: 'Women',
                  context: context),
              const VerticalDivider(color: Colors.grey),
              _items(
                  image: 'assets/images/child.png',
                  title: 'Kids & Baby',
                  context: context),
            ],
          ),
          categorySeparator(),
          _category(
            title: 'Sport & Travel',
            items: <Widget>[
              _items(
                  image: 'assets/images/athletic_clothing.png',
                  title: 'Athletic Clothings',
                  context: context),
              const VerticalDivider(color: Colors.grey),
              _items(
                  image: 'assets/images/sporting_equipment.png',
                  title: 'Sports Equipments',
                  context: context),
              const VerticalDivider(color: Colors.grey),
              _items(
                  image: 'assets/images/camping_equipment.png',
                  title: 'Camping',
                  context: context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _category({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              title,
              style: Font.styleHeadline6(),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Text(
                    'All Items',
                    style: Font.styleButton2(),
                  ),
                  const Icon(
                    Icons.navigate_next,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 150.0,
          child: ListView(scrollDirection: Axis.horizontal, children: items),
        )
      ],
    );
  }

  Widget categorySeparator() {
    return Column(
      children: const <Widget>[
        SizedBox(height: 10.0),
        Divider(color: Colors.grey),
      ],
    );
  }

  Widget _items({
    required String image,
    required String title,
    required BuildContext context,
  }) {
    return Button.raw(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProductCategory(),
          settings: RouteSettings(
            arguments: Arguments.category(title),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        width: 150.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black12, width: 1.3),
        ),
        child: Column(
          children: <Widget>[
            Image.asset(
              image,
              height: 105.0,
            ),
            SizedBox(
              height: 32.0,
              child: Center(
                child: Text(
                  title,
                  style: Font.styleCaption(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
