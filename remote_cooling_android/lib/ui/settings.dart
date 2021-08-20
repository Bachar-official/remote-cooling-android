import 'dart:math';

import 'package:flutter/material.dart';
import 'package:remote_cooling_android/utils/renderUtils.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  int port = 1337;
  int duration = 3;
  String pingCommand = 'ping';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки')
      ),
      body: Builder(
        builder: (ctx) => 
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
            children: [
              ...RenderUtils.renderForm([port, pingCommand, duration]),
              ElevatedButton(onPressed: () {
                if (_formKey.currentState.validate()) {
                  RouteUtils.showNotification(ctx, 'Успешно!', Colors.green);
                }
              },
              child: Text('OK'))
              ],
          ),
        ),
        ),   
      )
    );
  }
}