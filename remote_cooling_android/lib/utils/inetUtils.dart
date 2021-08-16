import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:http/http.dart' as http;

class InetUtils {
  static Future<List<String>> searchDevices() async {
    List<String> result = [];
    final String ip = await Wifi.ip;
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

  static String getCommand(ConditionerCommand command) {
    return command.toString().split('.')[1];
  }

  static Future<List<Conditioner>> getConditioners() async {
    List<Conditioner> result = [];
    List<String> addresses = await searchDevices();
    for (String address in addresses) {
      var response = await sendCommand(address, ConditionerCommand.ping);
      result.add(Conditioner.fromJson(json.decode(response.body)));
    }
    return result;
  }

  static Future<http.Response> sendCommand(String url, ConditionerCommand command) async {
    return await http.get(Uri.http(url, getCommand(command)));
  }
}
