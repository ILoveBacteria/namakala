import 'package:flutter/material.dart';

import '../../utilities/font.dart';

class Detail {
  IconData icon;
  String label;
  String? textValue;
  Color? colorValue;

  Detail.text(this.icon, this.label, this.textValue);
  Detail.color(this.icon, this.label, this.colorValue);

  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        Text(
          ' $label: ',
          style: Font.styleBody1(color: Colors.grey),
        ),
        textValue == null
            ? Container(width: 10.0, height: 10.0, color: colorValue)
            : SizedBox(
                width: MediaQuery.of(context).size.width - 251,
                child: Text(
                  textValue!,
                  style: Font.styleBody1(),
                  overflow: TextOverflow.ellipsis,
                )),
      ],
    );
  }
}
