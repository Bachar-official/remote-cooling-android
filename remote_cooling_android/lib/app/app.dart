import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';

class App extends StatefulWidget{
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinimex Conditioner',
      theme: ThemeData.dark(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}