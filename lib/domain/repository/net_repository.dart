import 'dart:async';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:dio/dio.dart';

class NetRepository {
  late String _userName;

  NetRepository({required String userName}) {
    this._userName = userName;
  }

  Map<String, String> getQueryParameters(ConditionerCommand command, DateTime dateTime) {
    if (command == ConditionerCommand.off ||
        command == ConditionerCommand.ping) {
      return {
        'date': dateTime.toString(),
        'user': _userName
        };
    }
    String stringCommand = commandDictionary[command]!;
    return {
      'profile': stringCommand,
      'date': dateTime.toString(),
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

  Future<Response> sendCommand(
      String url, ConditionerCommand command, DateTime dateTime, Dio dio) async {
    return dio
        .get('http://$url/${getCommand(command)}',
        queryParameters: getQueryParameters(command, dateTime));
  }
}
