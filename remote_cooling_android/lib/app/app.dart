import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/domain/view-model/settings-view-model.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<SettingsViewModel>(context, listen: true).theme;
    return MaterialApp(
          title: 'Cinimex Conditioner',
          theme: themeProvider,
          onGenerateRoute: AppRouter.generateRoute,
        );
  }
}
