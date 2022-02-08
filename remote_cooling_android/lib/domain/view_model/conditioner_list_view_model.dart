import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/domain/repository/broadcast_repository.dart';
import 'package:remote_cooling_android/domain/repository/settings_repository.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';

class ConditionerListViewModel extends ChangeNotifier {
  List<Conditioner> _list = [];
  bool _isLoading = false;
  final log = Logger('Conditioner list');
  late SettingsRepository _settings;
  late BroadcastRepository _broadcast;
  String broadcastIp = '255.255.255.255';

  ConditionerListViewModel() {
    _settings = SettingsRepository();
    _broadcast = BroadcastRepository(
        broadcastIp: broadcastIp,
        broadcastPort: _settings.port,
        delayInSeconds: _settings.duration,
        pingMessage: _settings.pingCommand);
    this.getConditioners();
  }

  List<Conditioner> get conditioners => _list;

  bool get isLoading => _isLoading;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  ///Mutate conditioner in the list
  void changeConditioner(Conditioner conditioner) {
    int index = _list.indexWhere((element) => element.endpoint == conditioner.endpoint);
    _list[index] = conditioner;
    notifyListeners();
  }

  ///Get conditioners from the network
  void getConditioners() async {
    _setLoading();
    log.info('Trying to fetch list of conditioners');
    try {
      _list = await _sendBroadcast();
      if (_list.length == 0) {
        log.warning('Something went wrong!');
      } else {
        log.fine('Gets new list with length ${_list.length}');
      }
    } catch (exception) {
      log.warning('Something went wrong: ${exception.toString()}');
      _list = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  ///Convert a list of String to list of conditioners
  Future<List<Conditioner>> _sendBroadcast() async {
    List<String> strings = [];
    try {
      strings = await _broadcast.sendBroadcast();
      log.fine('Found ${strings.length} records from broadcast.');
    } catch (e) {
      print(e.toString());
    }
    return strings.map((string) => Conditioner.fromJson(json.decode(string))).toList();
  }
}
