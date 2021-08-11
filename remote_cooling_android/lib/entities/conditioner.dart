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

  Conditioner(String name, String endpoint, ConditionerStatus status,
      DateTime updatedAt) {
    this.name = name;
    this.endpoint = endpoint;
    this.status = status;
    this.updatedAt = updatedAt;
  }

  Conditioner.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        endpoint = json['endpoint'],
        status = ConditionerStatus.undefined,
        updatedAt = DateTime.now();

  Map<String, dynamic> toJson() => {
        '\"name\"': '"$name"',
        '\"endpoint\"': '"$endpoint"',
      };
}
