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
  late Field titleField;
  late Field priceField;
  late Field colorField;
  late Field sizeField;
  late Field detailField;
  late Field countField;
  late Field categoryField;
  VoidCallback? _submitButton;
  File? imageFile;
  late Person person;
  Product? product;
  bool controllerInitialized = false;

  @override
  void initState() {
    super.initState();
    titleField = Field.field(
      label: 'Product title',
      hintText: 'iPhone 13',
      prefixIcon: Icons.title_outlined,
      setState: setState,
      validator: _titleValidator,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    priceField = Field.field(
      label: 'Price',
      hintText: '599',
      keyboardType: TextInputType.number,
      prefixIcon: Icons.attach_money,
      setState: setState,
      validator: _priceValidator,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    colorField = Field.field(
      label: 'Color',
      hintText: '0xAARRGGBB',
      prefixIcon: Icons.palette_outlined,
      setState: setState,
      validator: _colorValidator,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    sizeField = Field.field(
      label: 'Size',
      hintText: 'Write your size then press done button',
      prefixIcon: Icons.straighten_outlined,
      setState: setState,
      validator: _sizeValidator,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    countField = Field.field(
      label: 'Count',
      hintText: 'Number of products inventory',
      prefixIcon: Icons.shopping_bag_outlined,
      setState: setState,
      validator: _countValidator,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    categoryField = Field.field(
      label: 'Category',
      hintText: 'Mobiles, Laptops, ...',
      prefixIcon: Icons.category_outlined,
      setState: setState,
      validator: _categoryValidator,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    detailField = Field.field(
      label: 'More Detail',
      hintText: 'Write more information about your product...',
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      height: 200.0,
      setState: setState,
      validator: _detailValidator,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    Arguments arguments =
        ModalRoute.of(context)!.settings.arguments as Arguments;
    person = arguments.person!;
    product = arguments.product;

    if (!controllerInitialized) {
      if (product != null) {
        titleField.controller.text = product!.name;
        priceField.controller.text = '${product!.price}';
        colorField.controller.text =
            product!.color.map((e) => e.value).toList().join(' ');
        sizeField.controller.text = '${product?.size.join(' ')}';
        detailField.controller.text = product!.detail;
        countField.controller.text = '${product!.count}';
        categoryField.controller.text = product!.category;
      }
      controllerInitialized = true;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenSetting.initScreen(
        context: context,
        appBar:
            ScreenSetting.appBar(title: 'Add A New Product', context: context),
        child: Column(
          children: <Widget>[
            titleField.build(),
            Field.separate(),
            priceField.build(),
            Field.separate(),
            colorField.build(),
            Field.separate(),
            sizeField.build(),
            Field.separate(),
            countField.build(),
            Field.separate(),
            categoryField.build(),
            Field.separate(),
            detailField.build(),
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
    titleField.controller.text.isNotEmpty &&
            priceField.controller.text.isNotEmpty &&
            colorField.controller.text.isNotEmpty &&
            sizeField.controller.text.isNotEmpty &&
            countField.controller.text.isNotEmpty &&
            categoryField.controller.text.isNotEmpty &&
            imageFile != null &&
            detailField.controller.text.isNotEmpty
        ? _submitButton = () => _onAddProductButtonPressed()
        : _submitButton = null;
    setState(() {});
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

    Product newProduct = Product(
      titleField.controller.text,
      bytes,
      int.parse(priceField.controller.text),
      categoryField.controller.text,
      detailField.controller.text,
      colorField.controller.text.split(' ').map((e) => Color(int.parse(e))).toList(),
      sizeField.controller.text.split(' '),
      int.parse(countField.controller.text),
      Market(person.market.name),
      0,
    );

    return product == null
        ? _sendNewProductData(newProduct)
        : _sendEditedProductData(newProduct);
  }

  Future<bool> _sendNewProductData(Product product) async {
    MySocket socket = MySocket(UserData.phone, Command.addProductMarket,
        [jsonEncode(product.toJson2())]);
    String response = await socket.sendAndReceive();
    if (response == 'false') {
      SnackMessage('Failed to send data to server').build(context);
      return false;
    }
    return true;
  }

  Future<bool> _sendEditedProductData(Product product) async {
    MySocket socket = MySocket(UserData.phone, Command.editProductMarket,
        [jsonEncode(product.toJson2())]);
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
    return titleField.status == FieldStatus.validate &&
        priceField.status == FieldStatus.validate &&
        colorField.status == FieldStatus.validate &&
        sizeField.status == FieldStatus.validate &&
        countField.status == FieldStatus.validate &&
        categoryField.status == FieldStatus.validate &&
        detailField.status == FieldStatus.validate;
  }

  void _validateAllFields() {
    titleField.checkValid();
    priceField.checkValid();
    colorField.checkValid();
    sizeField.checkValid();
    detailField.checkValid();
    countField.checkValid();
    categoryField.checkValid();
  }

  bool _titleValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[a-zA-Z\d-() ]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _priceValidator(String? value) {
    if (value == null ||
        !RegExp(r'^\d*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _colorValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[\dA-Fx ]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _sizeValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[\d ]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _countValidator(String? value) {
    if (value == null ||
        !RegExp(r'^\d*$').hasMatch(value) ||
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
}
