import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/domain/repository/settings_repository.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/domain/repository/net_repository.dart';
import 'package:remote_cooling_android/utils/time_ago.dart';

class ConditionerViewModel extends ChangeNotifier {
  late Conditioner _conditioner;
  late Function mutateListWith;
  final log = Logger('Conditioner');
  bool _isLoading = false;
  late NetRepository _netRepository;
  late String _userName;
  late Dio _dio;

  ConditionerViewModel() {
    _userName = SettingsRepository().userName;
    _netRepository = NetRepository(userName: _userName);
    _dio = Dio();
  }

  Conditioner get conditioner => this._conditioner;

  bool get isLoading => _isLoading;

  ///Initiate conditioner to work
  @required
  void setConditioner(Conditioner newConditioner) {
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
      var response =
          await _netRepository.sendCommand(_conditioner.endpoint, command, DateTime.now(), _dio);
      if (response.statusCode == 200) {
        _conditioner.setStatus(response.data['status']);
        _conditioner.setUsername(response.data['user']);
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
      log.info(
          'Trying to switch conditioner \"${_conditioner.name}\" to state ${value ? '\"on\"' : '\"off\"'}');
      _setLoading();
      var response = await _netRepository.sendCommand(_conditioner.endpoint,
          on ? ConditionerCommand.off : ConditionerCommand.set_100, DateTime.now(), _dio);
      if (response.statusCode == 200) {
        _conditioner.setStatus(response.data['status']);
        _conditioner.setUsername(response.data['user']);
        log.fine('Switching ${value ? 'on' : 'off'} successful!');
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
