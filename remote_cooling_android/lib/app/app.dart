import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';

class App extends StatefulWidget{
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinimex Conditioner',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColorLight: Constants.mainOrange,
        primaryColor: Constants.mainBlue,
        scaffoldBackgroundColor: Constants.mainBlack,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Constants.mainOrange,
              onPrimary: Constants.mainBlack,
            ),
          ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}