import 'dart:convert';
import 'dart:io';

class Broadcast {
  List<dynamic> result;
  RawDatagramSocket socket;
  int port;
  InternetAddress address;

  Broadcast(InternetAddress address, int port) {
    this.result = [];
    this.address = address;
    this.port = port;
  }

  void _getEvent(RawSocketEvent event) {
    Datagram dg = socket.receive();
    if (dg != null) {
      print(utf8.decode(dg.data));
      this.result.add(utf8.decode(dg.data));
    }
  }

  void printList() {
    print(this.result.length);
    for(var e in result) {
      print(e);
    }
  }

  Future<void> doBroadcast() async {
    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
    socket.broadcastEnabled = true;
    List<int> callsign = utf8.encode('TEST');
    socket.listen(_getEvent);
    socket.send(callsign, address, 1337);
  }
}