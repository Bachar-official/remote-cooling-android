import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remote_cooling_android/domain/model/conditioner-list-model.dart';
import 'package:remote_cooling_android/domain/model/conditioner-model.dart';

void main() async {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName}: ${record.level.name}: ${record.time}: ${record.message}');
  });
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ConditionerListModel())
  ], child: App()));
}
