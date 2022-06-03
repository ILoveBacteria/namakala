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
  final _titleFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _marketFocus = FocusNode();
  final _sizeFocus = FocusNode();
  final _detailFocus = FocusNode();
  FieldStatus _titleStatus = FieldStatus.none;
  FieldStatus _priceStatus = FieldStatus.none;
  FieldStatus _marketStatus = FieldStatus.none;
  FieldStatus _sizeStatus = FieldStatus.none;
  FieldStatus _detailStatus = FieldStatus.none;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _marketController = TextEditingController();
  final _sizeController = TextEditingController();
  final _detailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleFocus.dispose();
    _priceFocus.dispose();
    _marketFocus.dispose();
    _sizeFocus.dispose();
    _detailFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenSetting.initScreen(
        context: context,
        appBar: ScreenSetting.appBar(title: 'Add A New Product', context: context),
        child: Column(
          children: [
            Field.field(
              label: 'Product title',
              hintText: 'iPhone 13',
              prefixIcon: Icons.title_outlined,
              focusNode: _titleFocus,
              controller: _titleController,
              status: _titleStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                setState(() {
                  _titleValidate(_titleController.text)
                      ? _titleStatus = FieldStatus.validate
                      : _titleStatus = FieldStatus.error;

                  _titleFocus.unfocus();
                });
              },
              onChanged: (_) => setState(() => _titleStatus = FieldStatus.none),
            ),
            Field.separate(),
            Field.field(
              label: 'Price',
              hintText: '599',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.attach_money,
              focusNode: _priceFocus,
              controller: _priceController,
              status: _priceStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                setState(() {
                  _priceValidate(_priceController.text)
                      ? _priceStatus = FieldStatus.validate
                      : _priceStatus = FieldStatus.error;

                  _priceFocus.unfocus();
                });
              },
              onChanged: (_) => setState(() => _priceStatus = FieldStatus.none),
            ),
            Field.separate(),
            Field.field(
              label: 'Market',
              // initialValue: 'person.market.name',
              hintText: 'Digikala',
              prefixIcon: Icons.store_outlined,
              focusNode: _marketFocus,
              controller: _marketController,
              status: _marketStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                setState(() {
                  Field.marketValidate(_marketController.text)
                      ? _marketStatus = FieldStatus.validate
                      : _marketStatus = FieldStatus.error;

                  _marketFocus.unfocus();
                });
              },
              onChanged: (_) => setState(() => _marketStatus = FieldStatus.none),
            ),
            Field.separate(),
            Field.field(
              label: 'Size',
              hintText: 'Write your size then press done button',
              prefixIcon: Icons.straighten_outlined,
              focusNode: _sizeFocus,
              controller: _sizeController,
              status: _sizeStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                setState(() {
                  _sizeValidate(_sizeController.text)
                      ? _sizeStatus = FieldStatus.validate
                      : _sizeStatus = FieldStatus.error;

                  _sizeFocus.unfocus();
                });
              },
              onChanged: (_) => setState(() => _sizeStatus = FieldStatus.none),
            ),
            Field.separate(),
            Field.field(
              label: 'More Detail',
              hintText: 'Write more information about your product...',
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              height: 200.0,
              focusNode: _detailFocus,
              controller: _detailController,
              status: _detailStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                setState(() {
                  _detailValidate(_detailController.text)
                      ? _detailStatus = FieldStatus.validate
                      : _detailStatus = FieldStatus.error;

                  _detailFocus.unfocus();
                });
              },
              onChanged: (_) => setState(() => _detailStatus = FieldStatus.none),
            ),
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

  bool _titleValidate(String? value) {
    if (value == null || RegExp(r'^[a-zA-Z0-9-() ]*$').hasMatch(value) || value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _priceValidate(String? value) {
    if (value == null || !RegExp(r'^[0-9]*$').hasMatch(value) || value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _sizeValidate(String? value) {
    if (value == null || !RegExp(r'^[0-9]*$').hasMatch(value) || value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _detailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }
}
