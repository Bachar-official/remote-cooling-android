import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';

class ConditionerListModel extends ChangeNotifier {
  ///List of conditioners
  List<Conditioner> _list = [];
  bool _isLoading = false;
  final log = Logger('Conditioner list');

  List<Conditioner> get conditioners => _list;

  bool get isLoading => _isLoading;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  ///Get conditioners from the network
  void getConditioners() async {
    _setLoading();
    log.info('Trying to fetch list of conditioners');
    try {
      _list = await InetUtils.sendBroadcast();
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
}
