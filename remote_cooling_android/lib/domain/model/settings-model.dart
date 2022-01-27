import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsModel extends ChangeNotifier {
  late int _port;
  late int _duration;
  late String _pingCommand;
  late String _userName;
  late bool _isDeveloper;
  late bool _autofocus;
  Box _settingsBox = Hive.box('settings');

  SettingsModel() {
    _port = _settingsBox.get('port', defaultValue: 1337);
    _duration = _settingsBox.get('duration', defaultValue: 2);
    _pingCommand = _settingsBox.get('command', defaultValue: 'ping');
    _userName = _settingsBox.get('user', defaultValue: 'Anonymous');
    _isDeveloper = _settingsBox.get('isDeveloper', defaultValue: false);
    _autofocus = true;
  }

  int get port => _port;
  int get duration => _duration;
  String get command => _pingCommand;
  String get userName => _userName;
  bool get isDeveloper => _isDeveloper;

  void setPort(int port) {
    _port = port;
    notifyListeners();
  }

  void setDuration(int duration) {
    _duration = duration;
    notifyListeners();
  }

  void setPingCommand(String command) {
    _pingCommand = command;
    notifyListeners();
  }

  void setUserName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  void setDeveloper(bool? isDeveloper) {
    if (isDeveloper == null) {
      _isDeveloper = false;
    } else {
      _isDeveloper = isDeveloper;
    }
    notifyListeners();
  }

  void _setAutofocus() {
    _autofocus = false;
    notifyListeners();
  }

  void storeSettings() {
    _settingsBox.put('port', _port);
    _settingsBox.put('duration', _duration);
    _settingsBox.put('command', _pingCommand);
    _settingsBox.put('user', _userName);
    _settingsBox.put('isDeveloper', _isDeveloper);
    _setAutofocus();
  }
}