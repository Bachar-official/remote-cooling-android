import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/domain/repository/settings-repository.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner-status.dart';
import 'package:remote_cooling_android/domain/repository/net-repository.dart';
import 'package:remote_cooling_android/utils/time-ago.dart';

class ConditionerViewModel extends ChangeNotifier {
  late Conditioner _conditioner;
  late Function mutateListWith;
  final log = Logger('Conditioner');
  bool _isLoading = false;
  late NetRepository _netRepository;
  late String _userName;

  ConditionerViewModel() {
    _userName = SettingsRepository().userName;
    _netRepository = NetRepository(userName: _userName);
  }

  Conditioner get conditioner => this._conditioner;
  bool get isLoading => _isLoading;
  String get updatedWhile => TimeAgo.timeAgoSinceDate(_conditioner.updatedAt);


  ///Initiate conditioner to work
  @required
  void setConditioner (Conditioner newConditioner) {
    _conditioner = newConditioner;
  }


  ///Initiate mutation from the list
  void setCallback(Function callback) {
    this.mutateListWith = callback;
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }


  ///Set another mode of conditioner
  void setMode(ConditionerStatus status) async {
    ConditionerCommand command = NetRepository.statusToCommand(status);
    try {
      log.info('Trying to set new mode: ${command.toString()}');
      _setLoading();
      var response = await _netRepository.sendCommand(_conditioner.endpoint, command);
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

  ///Switch conditioner on/off
  void switchOnOff(bool value) async {
    bool on = _conditioner.isOn;
    try {
      log.info('Trying to switch conditioner \"${_conditioner.name}\" to state ${value ? '\"on\"': '\"off\"'}');
      _setLoading();
      var response = await _netRepository.sendCommand(
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
}