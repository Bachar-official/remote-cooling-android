import 'dart:core';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/domain/repository/settings_repository.dart';
import 'package:remote_cooling_android/ui/ui_constants/theme.dart';

class SettingsViewModel extends ChangeNotifier {
  late int _port;
  late int _duration;
  late String _pingCommand;
  late String _userName;
  late bool _isDeveloper;
  late String _theme;
  late SettingsRepository _settingsRepository;
  final log = Logger('Settings');

  SettingsViewModel() {
    _settingsRepository = SettingsRepository();
    _port = _settingsRepository.port;
    _duration = _settingsRepository.duration;
    _pingCommand = _settingsRepository.pingCommand;
    _userName = _settingsRepository.userName;
    _isDeveloper = _settingsRepository.isDeveloper;
    _theme = _settingsRepository.themeName;
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
    log.fine('Sets port to value ${port.toString()}');
  }

  void setDuration(int duration) {
    _duration = duration;
    log.fine('Sets duration to value ${duration.toString()}');
  }

  void setPingCommand(String command) {
    _pingCommand = command;
    log.fine('Sets command to value ${command.toString()}');
  }

  void setUserName(String userName) {
    _userName = userName;
    log.fine('Sets userName to value ${userName.toString()}');
  }

  void setTheme(String themeName) {
    _theme = themeName;
    log.fine('Sets themeName to value ${themeName.toString()}');
    notifyListeners();
  }

  void setDeveloper(bool? isDeveloper) {
    if (isDeveloper == null) {
      _isDeveloper = false;
    } else {
      _isDeveloper = isDeveloper;
      log.fine('Sets isDeveloper to value ${isDeveloper.toString()}');
    }
    notifyListeners();
  }

  void storeSettings() {
    _settingsRepository.storeSettings(
        port: _port,
        duration: _duration,
        pingCommand: _pingCommand,
        userName: _userName,
        isDeveloper: _isDeveloper,
        themeName: _theme);
    log.fine('Settings stored successfully!');
    notifyListeners();
  }
}