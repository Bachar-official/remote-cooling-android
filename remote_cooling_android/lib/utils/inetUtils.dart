import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:http/http.dart' as http;

class InetUtils {

  static Map<String, String> getQueryParameters(ConditionerCommand command) {
    if (command == ConditionerCommand.off ||
        command == ConditionerCommand.ping) {
      return null;
    }
    List<String> stringCommand = command.toString().split('.');
    List<String> profileNumber = stringCommand[1].split('_');
    return {
      'profile': profileNumber[1],
    };
  }

  static ConditionerCommand statusToCommand(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.auto:
        return ConditionerCommand.set_100;
      case ConditionerStatus.fan:
        return ConditionerCommand.set_101;
      case ConditionerStatus.cold17:
        return ConditionerCommand.set_200;
      case ConditionerStatus.cold22:
        return ConditionerCommand.set_201;
      default:
        return ConditionerCommand.off;
    }
  }

  static String getCommand(ConditionerCommand command) {
    String commandPrefix = command.toString().split('.')[1];
    if (commandPrefix.contains('set')) {
      return 'set';
    }
    return commandPrefix;
  }

  static Future<http.Response> sendCommand(
      String url, ConditionerCommand command) async {
    return await http
        .get(Uri.http(url, getCommand(command), getQueryParameters(command)));
  }

  static Future<List<Conditioner>> sendBroadcast() async {
    List<Conditioner> result = [];
    InternetAddress destination = InternetAddress("255.255.255.255");
    RawDatagramSocket udp =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, 1337);
    List<int> message = utf8.encode('test');
    udp.broadcastEnabled = true;
    udp.listen((e) {
      Datagram dg = udp.receive();
      if (dg != null && dg.data.length != message.length) {
        var json = utf8.decode(dg.data);
        result.add(Conditioner.fromJson(jsonDecode(json)));
      }
    });
    udp.send(message, destination, 1337);
    await Future.delayed(Duration(seconds: 3));
    udp.close();
    return result;
  }
}
