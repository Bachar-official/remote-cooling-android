import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/domain/model/settings-model.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';
import 'package:remote_cooling_android/utils/validation.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var provider = Provider.of<SettingsModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Настройки',
          style: TextStyle(fontFamily: 'Europe'),
        )),
        body: Consumer<SettingsModel>(
          builder: (context, model, child) => Builder(
            builder: (ctx) => Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                        autofocus: true,
                        initialValue: provider.userName,
                        decoration:
                            InputDecoration(labelText: 'Имя пользователя'),
                        validator: ValidationUtils.validateEnglish,
                        onChanged: (newUser) => provider.setUserName(newUser)),
                    TextFormField(
                        initialValue: provider.port.toString(),
                        decoration: InputDecoration(labelText: 'Порт'),
                        validator: ValidationUtils.validatePort,
                        onChanged: (newPort) => {
                              provider.setPort(int.parse(newPort)),
                            }),
                    TextFormField(
                        initialValue: provider.command,
                        decoration: InputDecoration(
                            labelText: 'Команда для сканирования'),
                        validator: ValidationUtils.validateNull,
                        onChanged: (newCommand) =>
                            provider.setPingCommand(newCommand)),
                    TextFormField(
                        initialValue: provider.duration.toString(),
                        decoration: InputDecoration(
                            labelText: 'Длительность ожидания (сек.)'),
                        validator: ValidationUtils.validateDuration,
                        onChanged: (newDuration) => {
                              if (newDuration == '')
                                {
                                  provider.setDuration(0),
                                }
                              else
                                provider.setDuration(int.parse(newDuration))
                            }),
                    CheckboxListTile(
                        title: Text('Опции разработчика'),
                        activeColor: Constants.mainOrange,
                        value: provider.isDeveloper,
                        onChanged: (value) => provider.setDeveloper(value)),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            provider.storeSettings();
                            RouteUtils.showNotification(
                                ctx, 'Успешно!', Colors.green);
                          }
                        },
                        child: Text('Сохранить'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
