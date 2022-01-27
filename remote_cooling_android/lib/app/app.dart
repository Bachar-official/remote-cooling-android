import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/domain/model/conditioner-list-model.dart';
import 'package:remote_cooling_android/domain/model/conditioner-model.dart';
import 'package:remote_cooling_android/domain/model/settings-model.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ConditionerListModel()),
          ChangeNotifierProvider(create: (_) => ConditionerModel()),
          ChangeNotifierProvider(create: (_) => SettingsModel()),
        ],
        child: MaterialApp(
          title: 'Cinimex Conditioner',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColorLight: Constants.mainOrange,
            primaryColor: Constants.mainBlue,
            scaffoldBackgroundColor: Constants.mainBlue,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Constants.mainOrange,
                onPrimary: Constants.mainBlack,
              ),
            ),
          ),
          onGenerateRoute: AppRouter.generateRoute,
        ));
  }
}
