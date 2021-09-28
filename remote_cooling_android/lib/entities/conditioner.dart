import 'package:remote_cooling_android/entities/conditioner_status.dart';

class Conditioner {
  String name;
  String endpoint;
  ConditionerStatus status;
  DateTime updatedAt;
  String userName;

  static ConditionerStatus getConditionerStatus(String digitStatus) {
    switch (digitStatus) {
      case '200': return ConditionerStatus.cold17;
      case '201': return ConditionerStatus.cold22;
      case '202': return ConditionerStatus.hot30;
      case '100': return ConditionerStatus.auto;
      case '101': return ConditionerStatus.fan;
      case '300': return ConditionerStatus.off;
      default: return ConditionerStatus.undefined;
    }
  }

  Conditioner(String name, String endpoint, ConditionerStatus status,
      DateTime updatedAt, String userName) {
    this.name = name;
    this.endpoint = endpoint;
    this.status = status;
    this.updatedAt = updatedAt;
  }

  void setStatus(String status) {
    this.status = getConditionerStatus(status);
    this.updatedAt = DateTime.now();
  }

  void setUsername(String userName) {
    this.userName = userName;
  }

  @override
  String toString() {
    return 'name: $name, endpoint: $endpoint, status:$status';
  }

  Conditioner.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        endpoint = json['ipAddress'],
        status = getConditionerStatus(json['status']),
        updatedAt = DateTime.parse(json['date']),
        userName = json['user'];

  Map<String, dynamic> toJson() => {
        '\"name\"': '"$name"',
        '\"endpoint\"': '"$endpoint"',
      };
}
