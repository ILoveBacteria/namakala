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
  late String response;

  MySocket(this.sender, this.command, this.data);

  void send() async {
    await Socket.connect(host, port).then((socket) {
      if (data.isNotEmpty) {
        socket.write("${sender.phone} ${command.toString()} ${data.join(";")}\n");
      } else {
        socket.write("${sender.phone} ${command.toString()}\n");
      }
      socket.flush();
      socket.listen((event) {
        response = String.fromCharCodes(event);
      });
    });
  }
}