import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(App());
}