import 'package:flutter/material.dart';
import 'package:remote_cooling_android/ui/homepage.dart';
import 'package:remote_cooling_android/ui/conditioner_page.dart';
import 'package:remote_cooling_android/ui/about.dart';
import 'package:remote_cooling_android/ui/settings.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homepage:
      return _buildRoute((context) => Homepage(), routeSettings);
      case conditionerPage:
      return _buildRoute((context) => ConditionerPage(), routeSettings);
      case aboutPage:
      return _buildRoute((context) => AboutPage(), routeSettings);
      case settingsPage:
      return _buildRoute((context) => SettingsPage(), routeSettings);
      default: throw Exception("Unknown route: ${routeSettings.name}");
    }
  }

  static const String homepage = '/';
  static const String conditionerPage = '/conditionerPage';
  static const String aboutPage = '/about';
  static const String settingsPage = '/settings';
}

MaterialPageRoute _buildRoute(WidgetBuilder builder, settings) {
  return MaterialPageRoute(settings: settings, builder: builder);
}