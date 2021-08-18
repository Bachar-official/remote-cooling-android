import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:http/http.dart' as http;

class InetUtils {
  static Future<List<String>> searchDevices() async {
    List<String> result = [];
    String ip = '';
    if (Platform.isWindows) {
      List<NetworkInterface> list =  await NetworkInterface.list();
      for (NetworkInterface interface in list) {
        for(InternetAddress address in interface.addresses) {
          if (address.address.contains('192.168') || address.address.contains('192.167')) {
            ip = address.address;
          }
        }
      }
    } else if (Platform.isAndroid) {      
      ip = await Wifi.ip;
    }
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 1337;

    final stream = NetworkAnalyzer.discover2(subnet, port);
    List<NetworkAddress> adresses = await stream.toList();
    adresses.forEach((address) {
      if (address.exists) {
        result.add('${address.ip}:$port');
      }
    });
    return result;
  }

  static Map<String, String> getQueryParameters(ConditionerCommand command) {
    if (command == ConditionerCommand.off || command == ConditionerCommand.ping) {
      return null;
    }
    List<String> stringCommand = command.toString().split('.');
    List<String> profileNumber = stringCommand[1].split('_');
    return {
      'profile': profileNumber[1],
    };
  }

  static ConditionerCommand statusToCommand(ConditionerStatus status) {
    switch(status) {
      case ConditionerStatus.auto: return ConditionerCommand.set_100;
      case ConditionerStatus.fan: return ConditionerCommand.set_101;
      case ConditionerStatus.cold17: return ConditionerCommand.set_200;
      case ConditionerStatus.cold22: return ConditionerCommand.set_201;
      default: return ConditionerCommand.off;
    }
  }

  static String getCommand(ConditionerCommand command) {
    String commandPrefix = command.toString().split('.')[1];
    if (commandPrefix.contains('set')) {
      return 'set';
    }
    return commandPrefix;
  }

  static Future<List<Conditioner>> getConditioners() async {
    List<Conditioner> result = [];
    List<String> addresses = await searchDevices();
    for (String address in addresses) {
      var response = await sendCommand(address, ConditionerCommand.ping);
      if (response.statusCode == 200) {
        result.add(Conditioner.fromJson(json.decode(response.body)));
      }      
    }
    return result;
  }

  static Future<http.Response> sendCommand(String url, ConditionerCommand command) async {
    return await http.get(Uri.http(url, getCommand(command), getQueryParameters(command)));
  }
}
