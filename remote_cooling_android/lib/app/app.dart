import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/domain/view-model/settings-view-model.dart';
import 'package:skeletons/skeletons.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<SettingsViewModel>(context, listen: true).theme;
    return SkeletonTheme(
        darkShimmerGradient: LinearGradient(
        colors: [
          Color(0x55ED8B00),
          Color(0x99ED8B00),
          Color(0xFFED8B00),
          Color(0x99ED8B00),
          Color(0x55ED8B00),
    ],),
      child: MaterialApp(
            title: 'Cinimex Conditioner',
            theme: themeProvider,
            onGenerateRoute: AppRouter.generateRoute,
          ),
    );
  }
}
