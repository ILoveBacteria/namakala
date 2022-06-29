import 'package:flutter/material.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/button.dart';
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
  final _colorFocus = FocusNode();
  final _sizeFocus = FocusNode();
  final _detailFocus = FocusNode();
  FieldStatus _titleStatus = FieldStatus.none;
  FieldStatus _priceStatus = FieldStatus.none;
  FieldStatus _colorStatus = FieldStatus.none;
  FieldStatus _sizeStatus = FieldStatus.none;
  FieldStatus _detailStatus = FieldStatus.none;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _colorController = TextEditingController();
  final _sizeController = TextEditingController();
  final _detailController = TextEditingController();
  VoidCallback? _submitButton;

  @override
  void dispose() {
    super.dispose();
    _titleFocus.dispose();
    _priceFocus.dispose();
    _colorFocus.dispose();
    _sizeFocus.dispose();
    _detailFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

  void _changeButtonEnabled() {
    setState(() {
      _titleController.text.isNotEmpty &&
              _priceController.text.isNotEmpty &&
              _colorController.text.isNotEmpty &&
              _sizeController.text.isNotEmpty &&
              _detailController.text.isNotEmpty
          ? _submitButton = () => _onAddProductButtonPressed()
          : _submitButton = null;
    });
  }

  void _onAddProductButtonPressed() {
    _validateAllFields();
    setState(() {});

    if (_isValidateAllFields()) {
      _createNewProduct();
      Navigator.of(context).pop();
    }
  }

  void _createNewProduct() {
    // Product product =
  }

  bool _isValidateAllFields() {
    return _titleStatus == FieldStatus.validate &&
        _priceStatus == FieldStatus.validate &&
        _colorStatus == FieldStatus.validate &&
        _sizeStatus == FieldStatus.validate &&
        _detailStatus == FieldStatus.validate;
  }

  void _validateAllFields() {
    _titleValidate();
    _priceValidate();
    _colorValidate();
    _sizeValidate();
    _detailValidate();
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
        !RegExp(r'^[0-9]*$').hasMatch(value) ||
        value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _sizeValidator(String? value) {
    if (value == null ||
        !RegExp(r'^[0-9]*$').hasMatch(value) ||
        value.isEmpty) {
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

  void _detailValidate() {
    _detailValidator(_detailController.text)
        ? _detailStatus = FieldStatus.validate
        : _detailStatus = FieldStatus.error;

    _detailFocus.unfocus();
  }
}
