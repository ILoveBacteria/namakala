import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/utilities/product.dart';

import '../data/user_data.dart';
import '../socket/command.dart';
import '../socket/socket.dart';
import '../utilities/person.dart';
import 'snack_message.dart';

class FavoriteButton {
  final Product _product;
  final Person _person;

  FavoriteButton(this._product, this._person);

  Widget build(BuildContext context, Function setState) {
    return IconButton(
      onPressed: () async {
        // Add product to person.favorites if not already added or remove if already added
        if (_person.favorites.contains(_product)) {
          String response = await _sendRemoveFavoriteDataToServer();
          if (response == 'true') {
            _person.favorites.remove(_product);
            setState(() {});
          } else {
            SnackMessage('Failed to remove this from favorites').build(context);
          }
        } else {
          String response = await _sendAddFavoriteDataToServer();
          if (response == 'true') {
            _person.favorites.add(_product);
            setState(() {});
          } else {
            SnackMessage('Failed to add this to favorites').build(context);
          }
        }
      },
      icon: Icon(
        _person.favorites.contains(_product)
            ? Icons.favorite
            : Icons.favorite_outline,
        color: _person.favorites.contains(_product)
            ? Colors.red
            : Colors.blue,
      ),
    );
  }

  Future<String> _sendRemoveFavoriteDataToServer() async {
    MySocket socket = MySocket(UserData.phone, Command.removeFavorites, [jsonEncode(_product)]);
    String response = await socket.sendAndReceive();
    return response;
  }

  Future<String> _sendAddFavoriteDataToServer() async {
    MySocket socket = MySocket(UserData.phone, Command.addFavorites, [jsonEncode(_product)]);
    String response = await socket.sendAndReceive();
    return response;
  }
}