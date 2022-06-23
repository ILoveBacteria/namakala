import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:namakala/socket/command.dart';

import '../utilities/person.dart';

class MySocket {
  final int port = 5000;
  final String host = "10.0.2.2";
  final Person sender;
  final Command command;
  final List<String> data;

  MySocket(this.sender, this.command, this.data);

  Future<String> sendAndReceive() async {
    var socket = await Socket.connect(host, port);
    if (data.isNotEmpty) {
      socket.writeln("${sender.phone} ${command.name} ${data.join(";")}");
    } else {
      socket.writeln("${sender.phone} ${command.name}");
    }
    await socket.flush();
    String response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return response;
  }
}