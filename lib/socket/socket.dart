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
    Socket socket = await _send();
    String response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return response;
  }

  Future<Uint8List?> sendAndReceiveRaw() async {
    Uint8List? byte;
    Socket socket = await _send();
    socket.listen((event) async {
      byte = event;
      await socket.close();
    });

    return byte;
  }

  Future<Socket> _send() async {
    var socket = await Socket.connect(host, port);
    if (data.isNotEmpty) {
      socket.writeln("$phoneSender ${command.name} ${data.join(";")}");
    } else {
      socket.writeln("$phoneSender ${command.name}");
    }
    return socket;
  }
}
