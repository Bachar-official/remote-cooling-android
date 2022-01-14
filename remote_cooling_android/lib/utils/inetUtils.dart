import 'dart:async';
import 'dart:convert';
import 'package:remote_cooling_android/entities/broadcast.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class InetUtils {
  static Map<String, String> getQueryParameters(ConditionerCommand command) {
    Box settingsBox = Hive.box('settings');
    String userName = settingsBox.get('user', defaultValue: 'Anonymous');
    if (command == ConditionerCommand.off ||
        command == ConditionerCommand.ping) {
      return {
        'date': DateTime.now().toString(),
        'user': userName
        };
    }
    String stringCommand = commandDictionary[command]!;
    return {
      'profile': stringCommand,
      'date': DateTime.now().toString(),
      'user': userName
    };
  }

  static ConditionerCommand statusToCommand(ConditionerStatus status) {
    return statusCommandDictionary[status]!;
  }

  static String getCommand(ConditionerCommand command) {
    switch (command) {
      case ConditionerCommand.off:
      case ConditionerCommand.ping:
        return commandDictionary[command]!;
      default: return 'set';
    }
  }

  static Future<http.Response> sendCommand(
      String url, ConditionerCommand command) async {
    print(getCommand(command));
    return http
        .get(Uri.http(url, getCommand(command), getQueryParameters(command)));
  }

  static Future<List<Conditioner>> sendBroadcast() async {
    Box settingsBox = Hive.box('settings');
    String broadcastIP = "255.255.255.255";
    int broadcastPort = settingsBox.get('port', defaultValue: 1337);
    int delayInSeconds = settingsBox.get('duration', defaultValue: 2);
    String pingMessage = settingsBox.get('command', defaultValue: 'ping');
    List<Conditioner> result = [];
    Broadcast broadcast = Broadcast(
      broadcastIp: broadcastIP,
      broadcastPort: broadcastPort,
      delayInSeconds: delayInSeconds,
      pingMessage: pingMessage
    );
    List<String> strings = [];
    try {
      strings = await broadcast.sendBroadcast();
    } catch (e) {
      print(e.toString());
    }
    for (String str in strings) {
      result.add(Conditioner.fromJson(json.decode(str)));
    }
    return result;
  }
}
