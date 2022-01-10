import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';

class ConditionerListModel extends ChangeNotifier {
  ///List of conditioners
  List<Conditioner> _list = [];
  bool isLoading = false;
  final log = Logger('Conditioner list');

  ///Get conditioners from the network
  void getConditioners() async {
    isLoading = true;
    try {
      _list = await InetUtils.sendBroadcast();
      log.fine('gets new list with length ${_list.length}');
    } catch (exception) {
      log.warning('can not to fetch new list!');
      _list = [];
    }
    isLoading = false;
    notifyListeners();
  }
}