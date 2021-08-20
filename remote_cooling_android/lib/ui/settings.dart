import 'package:flutter/material.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remote_cooling_android/utils/validation.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  Box settingsBox = Hive.box('settings');
  int port;
  int duration;
  String pingCommand;

  @override
  void initState() {
    super.initState();
    port = settingsBox.get('port', defaultValue: 1337);
    duration = settingsBox.get('duration', defaultValue: 2);
    pingCommand = settingsBox.get('command', defaultValue: 'ping');
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(title: Text('Настройки')),
        body: Builder(
          builder: (ctx) => Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                      initialValue: port.toString(),
                      decoration: InputDecoration(labelText: 'Порт'),
                      validator: ValidationUtils.validatePort,
                      onChanged: (newPort) => {
                            port = int.parse(newPort),
                          }),
                  TextFormField(
                      initialValue: pingCommand,
                      decoration: InputDecoration(
                          labelText: 'Команда для сканирования'),
                      validator: ValidationUtils.validateNull,
                      onChanged: (newCommand) => {pingCommand = newCommand}),
                  TextFormField(
                      initialValue: duration.toString(),
                      decoration: InputDecoration(
                          labelText: 'Длительность ожидания (сек.)'),
                      validator: ValidationUtils.validateDuration,
                      onChanged: (newDuration) =>
                          {duration = int.parse(newDuration)}),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          settingsBox.put('port', port);
                          settingsBox.put('duration', duration);
                          settingsBox.put('command', pingCommand);
                          RouteUtils.showNotification(
                              ctx, 'Успешно!', Colors.green);
                        }
                      },
                      child: Text('Сохранить'))
                ],
              ),
            ),
          ),
        ));
  }
}
