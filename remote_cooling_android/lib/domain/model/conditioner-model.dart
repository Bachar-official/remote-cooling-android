import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';

class ConditionerModel extends ChangeNotifier {
  late Conditioner conditioner;
  final log = Logger('Conditioner');
  bool _isLoading = false;

  ConditionerModel({required this.conditioner});

  bool get isOn => _isConditionerOn(conditioner);
  String get stringMode => _getMode(conditioner.status);
  String get temperature => _getTemperature(conditioner.status);
  bool get isLoading => _isLoading;

  void setMode(ConditionerStatus status) async {
    ConditionerCommand command = InetUtils.statusToCommand(status);
    try {
      log.info('Trying to set new mode: ${command.toString()}');
      _isLoading = true;
      var response = await InetUtils.sendCommand(conditioner.endpoint, command);
      if (response.statusCode == 200) {
        conditioner.setStatus(json.decode(response.body)['status']);
        conditioner.setUsername(json.decode(response.body)['user']);
        log.info('Setting mode successful!');
      } else {
        log.warning('Something went wrong: status code ${response.statusCode}');
      }
    } catch (e) {
      log.warning('ERROR: ${e.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }

  void switchOnOff(bool value) async {
    bool on = _isConditionerOn(conditioner);
    try {
      log.info('Trying to switch conditioner \"${conditioner.name}\" to state ${value ? '\"on\"': '\"off\"'}');
      _isLoading = true;
      var response = await InetUtils.sendCommand(
          conditioner.endpoint,
          on
              ? ConditionerCommand.off
              : ConditionerCommand.set_100);
      if (response.statusCode == 200) {
        conditioner.setStatus(json.decode(response.body)['status']);
        conditioner.setUsername(json.decode(response.body)['user']);
        log.info('Switching ${value ? 'on': 'off'} successful!');
      } else {
        log.warning('Something went wrong: status code ${response.statusCode}');
      }
    } catch (e) {
      log.warning('ERROR: ${e.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }

  bool _isConditionerOn(Conditioner conditioner) {
    switch (conditioner.status) {
      case ConditionerStatus.off:
        return false;
      case ConditionerStatus.auto:
      case ConditionerStatus.cold17:
      case ConditionerStatus.cold22:
      case ConditionerStatus.hot30:
      case ConditionerStatus.fan:
        return true;
      default:
        return false;
    }
  }

  String _getMode(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.auto:
        return 'автоматически';
      case ConditionerStatus.cold17:
      case ConditionerStatus.cold22:
        return 'охлаждение';
      case ConditionerStatus.hot30:
        return 'обогрев';
      case ConditionerStatus.fan:
        return 'проветривание';
      case ConditionerStatus.off:
        return 'выключен';
      case ConditionerStatus.undefined:
      default:
        return '-';
    }
  }

  String _getTemperature(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.auto:
        return '--';
      case ConditionerStatus.cold17:
        return '17°С';
      case ConditionerStatus.cold22:
        return '22°С';
      case ConditionerStatus.hot30:
        return '30°С';
      case ConditionerStatus.fan:
        return '--';
      case ConditionerStatus.off:
        return '--';
      case ConditionerStatus.undefined:
      default:
        return '--';
    }
  }
}