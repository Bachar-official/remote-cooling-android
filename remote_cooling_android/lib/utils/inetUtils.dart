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
    List<String> stringCommand = command.toString().split('.');
    List<String> profileNumber = stringCommand[1].split('_');
    return {
      'profile': profileNumber[1],
      'date': DateTime.now().toString(),
      'user': userName
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
      case ConditionerStatus.hot30:
        return ConditionerCommand.set_202;
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
    List<String> strings = await broadcast.sendBroadcast();
    for (String str in strings) {
      result.add(Conditioner.fromJson(json.decode(str)));
    }
    return result;
  }
}
