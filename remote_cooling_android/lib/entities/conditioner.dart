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

}