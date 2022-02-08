import 'dart:async';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:http/http.dart' as http;

class NetRepository {
  late String _userName;

  NetRepository({required String userName}) {
    this._userName = userName;
  }

  Map<String, String> getQueryParameters(ConditionerCommand command) {
    if (command == ConditionerCommand.off ||
        command == ConditionerCommand.ping) {
      return {
        'date': DateTime.now().toString(),
        'user': _userName
        };
    }
    String stringCommand = commandDictionary[command]!;
    return {
      'profile': stringCommand,
      'date': DateTime.now().toString(),
      'user': _userName
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

  Future<http.Response> sendCommand(
      String url, ConditionerCommand command) async {
    return http
        .get(Uri.http(url, getCommand(command), getQueryParameters(command)));
  }
}
