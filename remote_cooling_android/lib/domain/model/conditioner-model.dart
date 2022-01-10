import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';

class ConditionerModel extends ChangeNotifier {
  late Conditioner conditioner;
  final log = Logger('Conditioner');

  bool get isOn => _isConditionerOn(conditioner);
  String get stringMode => _getMode(conditioner.status);
  String get temperature => _getTemperature(conditioner.status);

  ConditionerModel({required this.conditioner});

  void setMode(ConditionerStatus status) {
    //TODO: implement method
  }

  bool _isConditionerOn(Conditioner conditioner) {
    switch (conditioner.status) {
      case ConditionerStatus.off:
        return false;
      case ConditionerStatus.auto:
      case ConditionerStatus.cold17:
      case ConditionerStatus.cold22:
      case ConditionerStatus.hot30:
      case ConditionerStatus.fan:
        return true;
      default:
        return false;
    }
  }

  String _getMode(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.auto:
        return 'автоматически';
      case ConditionerStatus.cold17:
      case ConditionerStatus.cold22:
        return 'охлаждение';
      case ConditionerStatus.hot30:
        return 'обогрев';
      case ConditionerStatus.fan:
        return 'проветривание';
      case ConditionerStatus.off:
        return 'выключен';
      case ConditionerStatus.undefined:
      default:
        return '-';
    }
  }

  String _getTemperature(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.auto:
        return '--';
      case ConditionerStatus.cold17:
        return '17°С';
      case ConditionerStatus.cold22:
        return '22°С';
      case ConditionerStatus.hot30:
        return '30°С';
      case ConditionerStatus.fan:
        return '--';
      case ConditionerStatus.off:
        return '--';
      case ConditionerStatus.undefined:
      default:
        return '--';
    }
  }
}