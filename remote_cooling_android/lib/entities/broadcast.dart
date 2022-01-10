import 'dart:convert';
import 'dart:io';

class Broadcast {
  final String broadcastIp;
  final String pingMessage;
  final int delayInSeconds;
  final int broadcastPort;

  Broadcast(
      {required this.broadcastIp,
      required this.broadcastPort,
      required this.delayInSeconds,
      required this.pingMessage});

  Future<List<String>> sendBroadcast() async {
    List<String> result = [];
    InternetAddress destination = InternetAddress(broadcastIp);
    List<int> message = utf8.encode(pingMessage);
    RawDatagramSocket udp =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, broadcastPort);
    udp.broadcastEnabled = true;
    udp.listen((event) {
      Datagram? datagram = udp.receive();
      if (datagram != null && datagram.data.length != message.length) {
        result.add(utf8.decode(datagram.data));
      }
    });
    udp.send(message, destination, broadcastPort);

    await Future.delayed(Duration(seconds: delayInSeconds));
    udp.close();
    return result;
  }
}
