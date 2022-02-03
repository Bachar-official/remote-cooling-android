import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/domain/repository/net-repository.dart';

class ConditionerListViewModel extends ChangeNotifier {
  ///List of conditioners
  List<Conditioner> _list = [];
  bool _isLoading = false;
  final log = Logger('Conditioner list');

  ConditionerListViewModel() {
    this.getConditioners();
  }

  List<Conditioner> get conditioners => _list;

  bool get isLoading => _isLoading;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

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
      _list = await NetRepository.sendBroadcast();
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