import 'package:hive/hive.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';

@HiveType(typeId: 0)
class Conditioner extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String endpoint;

  @HiveField(2)
  ConditionerStatus status;

  @HiveField(3)
  DateTime updatedAt;

  static ConditionerStatus getConditionerStatus(String digitStatus) {
    switch (digitStatus) {
      case '200':
        return ConditionerStatus.on;
      case '300':
        return ConditionerStatus.off;
      default:
        return ConditionerStatus.undefined;
    }
  }

  Conditioner(String name, String endpoint, ConditionerStatus status,
      DateTime updatedAt) {
    this.name = name;
    this.endpoint = endpoint;
    this.status = status;
    this.updatedAt = updatedAt;
  }

  void setStatus(String status) {
    this.status = getConditionerStatus(status);
    this.updatedAt = DateTime.now();
  }

  @override
  String toString() {
    return 'name: $name, endpoint: $endpoint, status:$status';
  }

  Conditioner.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        endpoint = json['ipAddress'],
        status = getConditionerStatus(json['status']),
        updatedAt = DateTime.now();

  Map<String, dynamic> toJson() => {
        '\"name\"': '"$name"',
        '\"endpoint\"': '"$endpoint"',
      };
}
