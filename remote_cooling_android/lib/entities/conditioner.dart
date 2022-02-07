import 'package:remote_cooling_android/entities/conditioner-status.dart';

class Conditioner {
  late String _name;
  late String _endpoint;
  late ConditionerStatus _status;
  late DateTime _updatedAt;
  late String _userName;

  static ConditionerStatus getConditionerStatus(String digitStatus) {
    switch (digitStatus) {
      case '200':
        return ConditionerStatus.cold17;
      case '201':
        return ConditionerStatus.cold22;
      case '202':
        return ConditionerStatus.hot30;
      case '100':
        return ConditionerStatus.auto;
      case '101':
        return ConditionerStatus.fan;
      case '300':
        return ConditionerStatus.off;
      default:
        return ConditionerStatus.undefined;
    }
  }

  Conditioner(String name, String endpoint, ConditionerStatus status,
      DateTime updatedAt, String userName) {
    this._name = name;
    this._endpoint = endpoint;
    this._status = status;
    this._updatedAt = updatedAt;
    this._userName = userName;
  }

  String get name => _name;

  String get endpoint => _endpoint;

  ConditionerStatus get status => _status;

  DateTime get updatedAt => _updatedAt;

  String get userName => _userName;

  bool get isOn => _isConditionerOn();

  String get temperature => _getTemperature();

  void setStatus(String status) {
    this._status = getConditionerStatus(status);
    this._updatedAt = DateTime.now();
  }

  void setUsername(String userName) {
    this._userName = userName;
  }

  @override
  String toString() {
    return 'name: $_name, endpoint: $_endpoint, status:$_status';
  }

  bool isEquals(Conditioner another) {
    return (this.name == another.name &&
        this.status == another.status &&
        this.userName == another.userName &&
        this.endpoint == another.endpoint &&
        this.updatedAt == another.updatedAt);
  }

  Conditioner.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _endpoint = json['ipAddress'],
        _status = getConditionerStatus(json['status']),
        _updatedAt = DateTime.parse(json['date']),
        _userName = json['user'];

  bool _isConditionerOn() {
    switch (_status) {
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

  String _getTemperature() {
    switch (_status) {
      case ConditionerStatus.auto:
        return 'автоматический';
      case ConditionerStatus.cold17:
        return '17°С';
      case ConditionerStatus.cold22:
        return '22°С';
      case ConditionerStatus.hot30:
        return '30°С';
      case ConditionerStatus.fan:
        return 'проветривание';
      case ConditionerStatus.off:
        return 'выключен';
      case ConditionerStatus.undefined:
      default:
        return 'неизвестно';
    }
  }
}
