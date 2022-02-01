import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:remote_cooling_android/entities/theme.dart';

class SettingsModel extends ChangeNotifier {
  late int _port;
  late int _duration;
  late String _pingCommand;
  late String _userName;
  late bool _isDeveloper;
  late String _theme;
  Box _settingsBox = Hive.box('settings');

  SettingsModel() {
    _port = _settingsBox.get('port', defaultValue: 1337);
    _duration = _settingsBox.get('duration', defaultValue: 2);
    _pingCommand = _settingsBox.get('command', defaultValue: 'ping');
    _userName = _settingsBox.get('user', defaultValue: 'Anonymous');
    _isDeveloper = _settingsBox.get('isDeveloper', defaultValue: false);
    _theme = _settingsBox.get('theme', defaultValue: 'Cinimex');
  }

  int get port => _port;
  int get duration => _duration;
  String get command => _pingCommand;
  String get userName => _userName;
  bool get isDeveloper => _isDeveloper;
  ThemeData get theme => getTheme(_theme);
  String get themeName => _theme;

  void setPort(int port) {
    _port = port;
  }

  void setDuration(int duration) {
    _duration = duration;
  }

  void setPingCommand(String command) {
    _pingCommand = command;
  }

  void setUserName(String userName) {
    _userName = userName;
  }

  void setTheme(String themeName) {
    _theme = themeName;
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

  void storeSettings() {
    _settingsBox.put('port', _port);
    _settingsBox.put('duration', _duration);
    _settingsBox.put('command', _pingCommand);
    _settingsBox.put('user', _userName);
    _settingsBox.put('isDeveloper', _isDeveloper);
    _settingsBox.put('theme', _theme);
    notifyListeners();
  }
}