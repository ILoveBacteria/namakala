import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/socket/command.dart';
import 'package:namakala/socket/socket.dart';
import 'package:namakala/utilities/market.dart';
import 'package:namakala/utilities/person.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/field.dart';
import 'package:namakala/widgets/screen_setting.dart';
import 'package:namakala/widgets/snack_message.dart';

import '../utilities/arguments.dart';
import '../utilities/product.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _titleFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _colorFocus = FocusNode();
  final _sizeFocus = FocusNode();
  final _detailFocus = FocusNode();
  final _countFocus = FocusNode();
  final _categoryFocus = FocusNode();
  FieldStatus _titleStatus = FieldStatus.none;
  FieldStatus _priceStatus = FieldStatus.none;
  FieldStatus _colorStatus = FieldStatus.none;
  FieldStatus _sizeStatus = FieldStatus.none;
  FieldStatus _detailStatus = FieldStatus.none;
  FieldStatus _categoryStatus = FieldStatus.none;
  FieldStatus _countStatus = FieldStatus.none;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _colorController = TextEditingController();
  final _sizeController = TextEditingController();
  final _detailController = TextEditingController();
  final _countController = TextEditingController();
  final _categoryController = TextEditingController();
  VoidCallback? _submitButton;
  File? imageFile;
  late Person person;
  Product? product;

  @override
  void dispose() {
    super.dispose();
    _titleFocus.dispose();
    _priceFocus.dispose();
    _colorFocus.dispose();
    _sizeFocus.dispose();
    _detailFocus.dispose();
    _countFocus.dispose();
    _categoryFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Arguments arguments = ModalRoute.of(context)!.settings.arguments as Arguments;
    person = arguments.person!;
    product = arguments.product;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenSetting.initScreen(
        context: context,
        appBar:
            ScreenSetting.appBar(title: 'Add A New Product', context: context),
        child: Column(
          children: <Widget>[
            Field.field(
              label: 'Product title',
              hintText: 'iPhone 13',
              prefixIcon: Icons.title_outlined,
              focusNode: _titleFocus,
              controller: _titleController,
              status: _titleStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                _titleValidate();
                setState(() {});
              },
              onChanged: (_) {
                _titleStatus = FieldStatus.none;
                _changeButtonEnabled();
                setState(() {});
              },
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
                _priceValidate();
                setState(() {});
              },
              onChanged: (_) {
                _priceStatus = FieldStatus.none;
                _changeButtonEnabled();
                setState(() {});
              },
            ),
            Field.separate(),
            Field.field(
              label: 'Color',
              hintText: '0xAARRGGBB',
              prefixIcon: Icons.palette_outlined,
              focusNode: _colorFocus,
              controller: _colorController,
              status: _colorStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                _colorValidate();
                setState(() {});
              },
              onChanged: (_) {
                _colorStatus = FieldStatus.none;
                _changeButtonEnabled();
                setState(() {});
              },
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
                _sizeValidate();
                setState(() {});
              },
              onChanged: (_) {
                _sizeStatus = FieldStatus.none;
                _changeButtonEnabled();
                setState(() {});
              },
            ),
            Field.separate(),
            Field.field(
              label: 'Count',
              hintText: 'Number of products inventory',
              prefixIcon: Icons.shopping_bag_outlined,
              focusNode: _countFocus,
              controller: _countController,
              status: _countStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                _countValidate();
                setState(() {});
              },
              onChanged: (_) {
                _countStatus = FieldStatus.none;
                _changeButtonEnabled();
                setState(() {});
              },
            ),
            Field.separate(),
            Field.field(
              label: 'Category',
              hintText: 'Mobiles, Laptops, ...',
              prefixIcon: Icons.category_outlined,
              focusNode: _categoryFocus,
              controller: _categoryController,
              status: _categoryStatus,
              onTap: () => setState(() {}),
              onEditingComplete: () {
                _categoryValidate();
                setState(() {});
              },
              onChanged: (_) {
                _categoryStatus = FieldStatus.none;
                _changeButtonEnabled();
                setState(() {});
              },
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
                _detailValidate();
                setState(() {});
              },
              onChanged: (_) {
                _detailStatus = FieldStatus.none;
                _changeButtonEnabled();
                setState(() {});
              },
            ),
            Field.separate(),
            Field.container(
              height: 100.0,
              leftPadding: 10.0,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: imageFile != null
                        ? Image.file(imageFile!)
                        : Image.asset('assets/images/image.png'),
                  ),
                  const Spacer(),
                  Button.elevatedIcon(
                    icon: Icons.add_photo_alternate_outlined,
                    label: 'ADD IMAGE',
                    color: Colors.lightGreen,
                    onPressed: _getFromGallery,
                  ),
                ],
              ),
            ),
            Button.separate(),
            Button.elevated(
              text: 'ADD PRODUCT',
              color: Colors.teal,
              onPressed: _submitButton,
            ),
          ],
        ),
      ),
    );
  }

  List<String> categoryNameList() {
    return <String>[
      'Mobiles',
      'Laptops',
      'Camera',
      'Tablets',
      'Men',
      'Women',
      'Kids & Baby',
      'Athletic Clothings',
      'Sports Equipments',
      'Camping',
    ];
  }

  void _changeButtonEnabled() {
    setState(() {
      _titleController.text.isNotEmpty &&
              _priceController.text.isNotEmpty &&
              _colorController.text.isNotEmpty &&
              _sizeController.text.isNotEmpty &&
              _countController.text.isNotEmpty &&
              _categoryController.text.isNotEmpty &&
              imageFile != null &&
              _detailController.text.isNotEmpty
          ? _submitButton = () => _onAddProductButtonPressed()
          : _submitButton = null;
    });
  }

  void _onAddProductButtonPressed() async {
    _validateAllFields();
    setState(() {});

    if (_isValidateAllFields() && await _createNewProduct()) {
      Navigator.of(context).pop();
    }
  }

  Future<bool> _createNewProduct() async {
    Uint8List bytes = await imageFile!.readAsBytes();

    Product product = Product(
      _titleController.text,
      bytes,
      int.parse(_priceController.text),
      _categoryController.text,
      _detailController.text,
      _colorController.text.split(' ').map((e) => Color(int.parse(e))).toList(),
      _sizeController.text.split(' '),
      int.parse(_countController.text),
      Market(person.market.name),
    );

    MySocket socket = MySocket(UserData.phone, Command.addProductMarket, [jsonEncode(product.toJson2())]);
    String response = await socket.sendAndReceive();
    if (response == 'false') {
      SnackMessage('Failed to send data to server').build(context);
      return false;
    }
    return true;
  }

  _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _changeButtonEnabled();
      });
    }
  }

  bool _isValidateAllFields() {
    return _titleStatus == FieldStatus.validate &&
        _priceStatus == FieldStatus.validate &&
        _colorStatus == FieldStatus.validate &&
        _sizeStatus == FieldStatus.validate &&
        _countStatus == FieldStatus.validate &&
        _categoryStatus == FieldStatus.validate &&
        _detailStatus == FieldStatus.validate;
  }

  void _validateAllFields() {
    _titleValidate();
    _priceValidate();
    _colorValidate();
    _sizeValidate();
    _detailValidate();
    _countValidate();
    _categoryValidate();
  }

  bool _titleValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[a-zA-Z0-9-() ]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _priceValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[0-9]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _colorValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[0-9A-Fx ]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _sizeValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[0-9 ]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _countValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[0-9]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _categoryValidator(String? value) {
    if (value == null || !categoryNameList().contains(value) || value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _detailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }

  void _titleValidate() {
    _titleValidator(_titleController.text)
        ? _titleStatus = FieldStatus.validate
        : _titleStatus = FieldStatus.error;

    _titleFocus.unfocus();
  }

  void _priceValidate() {
    _priceValidator(_priceController.text)
        ? _priceStatus = FieldStatus.validate
        : _priceStatus = FieldStatus.error;

    _priceFocus.unfocus();
  }

  void _colorValidate() {
    _colorValidator(_colorController.text)
        ? _colorStatus = FieldStatus.validate
        : _colorStatus = FieldStatus.error;

    _colorFocus.unfocus();
  }

  void _sizeValidate() {
    _sizeValidator(_sizeController.text)
        ? _sizeStatus = FieldStatus.validate
        : _sizeStatus = FieldStatus.error;

    _sizeFocus.unfocus();
  }

  void _countValidate() {
    _countValidator(_countController.text)
        ? _countStatus = FieldStatus.validate
        : _countStatus = FieldStatus.error;

    _countFocus.unfocus();
  }

  void _categoryValidate() {
    _categoryValidator(_categoryController.text)
        ? _categoryStatus = FieldStatus.validate
        : _categoryStatus = FieldStatus.error;

    _categoryFocus.unfocus();
  }

  void _detailValidate() {
    _detailValidator(_detailController.text)
        ? _detailStatus = FieldStatus.validate
        : _detailStatus = FieldStatus.error;

    _detailFocus.unfocus();
  }
}
