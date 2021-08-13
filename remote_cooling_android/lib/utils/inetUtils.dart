import 'dart:convert';

import 'package:remote_cooling_android/entities/conditioner.dart';
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

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  static Future<http.Response> pingHost(String url) async {
    return http.get(Uri.http(url, 'ping'));
  }
}
