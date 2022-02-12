import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remote_cooling_android/domain/view_model/conditioner_view_model.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';

void main() {
  setUp(() async {
    await Hive.initFlutter();
    await Hive.openBox('settings');
  });

  test('should set a conditioner', () async {
    Conditioner testConditioner = Conditioner('test', '127.0.0.1', ConditionerStatus.auto, DateTime.now(), 'testUser');
    ConditionerViewModel model = ConditionerViewModel();
    model.setConditioner(testConditioner);
    expect(model.conditioner.isEquals(testConditioner), true);
  });

  tearDown(() async {
    await Hive.close();
  });
}