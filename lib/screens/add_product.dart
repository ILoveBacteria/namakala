import 'package:flutter/material.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/field.dart';
import 'package:namakala/widgets/screen_setting.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<Widget> _sizeChips = <Widget>[];
  List _size = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenSetting.initScreen(
        context: context,
        appBar: ScreenSetting.appBar(title: 'Add A New Product', context: context),
        child: Column(
          children: [
            Field.field(label: 'Product title', hintText: 'iPhone 13', prefixIcon: Icons.title_outlined),
            Field.separate(),
            Field.field(label: 'Price', hintText: '599' ,keyboardType: TextInputType.number, prefixIcon: Icons.attach_money),
            Field.separate(),
            Field.field(label: 'Market', initialValue: 'person.market.name', hintText: 'Digikala', prefixIcon: Icons.store_outlined,),
            Field.separate(),
            Field.field(label: 'Size', hintText: 'Write your size then press done button', prefixIcon: Icons.straighten_outlined),
            Field.separate(),
            Field.field(label: 'More Detail', hintText: 'Write more information about your product...', keyboardType: TextInputType.multiline, maxLines: 10, height: 200.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeChips({required String label}) {
    return InputChip(
      label: Text(
        label,
        style: Font.styleBody1(),
      ),
      deleteIcon: const Icon(Icons.remove),
    );
  }
}
