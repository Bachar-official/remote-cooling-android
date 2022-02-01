import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';
import 'package:remote_cooling_android/utils/time_ago.dart';

class ConditionerModel extends ChangeNotifier {
  late Conditioner _conditioner;
  late Function mutateListWith;
  final log = Logger('Conditioner');
  bool _isLoading = false;

  Conditioner get conditioner => this._conditioner;
  bool get isOn => _isConditionerOn(_conditioner);
  String get temperature => _getTemperature(_conditioner.status);
  bool get isLoading => _isLoading;
  String get updatedWhile => TimeAgo.timeAgoSinceDate(_conditioner.updatedAt);

  @required
  void setConditioner (Conditioner newConditioner) {
    _conditioner = newConditioner;
  }

  void setCallback(Function callback) {
    this.mutateListWith = callback;
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void setMode(ConditionerStatus status) async {
    ConditionerCommand command = InetUtils.statusToCommand(status);
    try {
      log.info('Trying to set new mode: ${command.toString()}');
      _setLoading();
      var response = await InetUtils.sendCommand(_conditioner.endpoint, command);
      if (response.statusCode == 200) {
        var answer = json.decode(response.body);
        _conditioner.setStatus(answer['status']);
        _conditioner.setUsername(answer['user']);
        log.fine('Setting mode successful!');
      } else {
        log.warning('Something went wrong: status code ${response.statusCode}');
      }
    } catch (e) {
      log.warning('ERROR: ${e.toString()}');
    }
    mutateListWith(_conditioner);
    _isLoading = false;
    notifyListeners();
  }

  void switchOnOff(bool value) async {
    bool on = _isConditionerOn(_conditioner);
    try {
      log.info('Trying to switch conditioner \"${_conditioner.name}\" to state ${value ? '\"on\"': '\"off\"'}');
      _setLoading();
      var response = await InetUtils.sendCommand(
          _conditioner.endpoint,
          on
              ? ConditionerCommand.off
              : ConditionerCommand.set_100);
      if (response.statusCode == 200) {
        var answer = json.decode(response.body);
        _conditioner.setStatus(answer['status']);
        _conditioner.setUsername(answer['user']);
        log.fine('Switching ${value ? 'on': 'off'} successful!');
      } else {
        log.warning('Something went wrong: status code ${response.statusCode}');
      }
    } catch (e) {
      log.warning('ERROR: ${e.toString()}');
    }
    mutateListWith(_conditioner);
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

  String _getTemperature(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.auto:
        return 'автоматический';
      case ConditionerStatus.cold17:
        return '17°С';
      case ConditionerStatus.cold22:
        return '22°С';
      case ConditionerStatus.hot30:
        return '30°С';
      case ConditionerStatus.fan:
        return 'проветривание';
      case ConditionerStatus.off:
        return 'выключен';
      case ConditionerStatus.undefined:
      default:
        return 'неизвестно';
    }
  }
}