import 'package:hive/hive.dart';

class SettingsRepository {
  late Box _settingsBox;

  SettingsRepository() {
    _settingsBox = Hive.box('settings');
  }

  int get port => _settingsBox.get('port', defaultValue: 1337);
  int get duration => _settingsBox.get('duration', defaultValue: 2);
  String get pingCommand => _settingsBox.get('command', defaultValue: 'ping');
  String get userName => _settingsBox.get('user', defaultValue: 'Anonymous');
  bool get isDeveloper => _settingsBox.get('isDeveloper', defaultValue: false);
  String get themeName => _settingsBox.get('theme', defaultValue: 'Cinimex');

  void storeSettings({
    required int port,
    required int duration,
    required String pingCommand,
    required String userName,
    required bool isDeveloper,
    required String themeName
  }) {
    _settingsBox.put('port', port);
    _settingsBox.put('duration', duration);
    _settingsBox.put('command', pingCommand);
    _settingsBox.put('user', userName);
    _settingsBox.put('isDeveloper', isDeveloper);
    _settingsBox.put('theme', themeName);
  }
}