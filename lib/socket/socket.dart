import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:namakala/socket/command.dart';

class MySocket {
  final int port = 5000;
  final String host = "10.0.2.2";
  final String? phoneSender;
  final Command command;
  final List<String> data;

  MySocket(this.phoneSender, this.command, this.data);

  Future<String> sendAndReceive() async {
    var socket = await Socket.connect(host, port);

    if (data.isNotEmpty) {
      socket.writeln("$phoneSender ${command.name} ${data.join(";")}");
    } else {
      socket.writeln("$phoneSender ${command.name}");
    }

    String response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return response;
  }
}
