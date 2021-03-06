import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:remote_cooling_android/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'domain/view_model/conditioner_list_view_model.dart';
import 'domain/view_model/conditioner_view_model.dart';
import 'domain/view_model/navigation_view_model.dart';
import 'domain/view_model/settings_view_model.dart';

void main() async {
  ansiColorDisabled = false;
  final whitePen = AnsiPen()..white(bold: true);
  final redPen = AnsiPen()..red(bold: true);
  final bluePen = AnsiPen()..blue(bold: true);
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    String message = '${record.loggerName}: ${record.level.name}: ${record.time}: ${record.message}';
    switch(record.level.name) {
      case 'WARNING': print(redPen(message)); break;
      case 'FINE': print(bluePen(message)); break;
      default: print(whitePen(message));
    }
  });
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConditionerListViewModel()),
        ChangeNotifierProvider(create: (_) => ConditionerViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
      child: App()));
}
