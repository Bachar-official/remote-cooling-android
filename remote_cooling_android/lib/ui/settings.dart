import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/model/settings-model.dart';
import 'package:remote_cooling_android/entities/theme.dart';
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
    final MainAxisAlignment rowAlignment = MainAxisAlignment.spaceBetween;
    final TextStyle textStyle = TextStyle(fontSize: 13);

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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                          initialValue: provider.userName,
                          decoration:
                              InputDecoration(labelText: 'Имя пользователя'),
                          validator: ValidationUtils.validateEnglish,
                          onChanged: (newUser) =>
                              provider.setUserName(newUser)),
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
                      Row(
                        mainAxisAlignment: rowAlignment,
                        children: [
                          Text(
                            'Тема оформления',
                            style: textStyle,
                          ),
                          DropdownButton<String>(
                            value: provider.themeName,
                            items: _themeList(
                                themeDictionary.keys.toList(), textStyle),
                            onChanged: (value) => provider.setTheme(value!),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: rowAlignment,
                        children: [
                          Text('Режим разработчика', style: textStyle),
                          Checkbox(
                              //activeColor: Constants.mainOrange,
                              value: provider.isDeveloper,
                              onChanged: (value) =>
                                  provider.setDeveloper(value)),
                        ],
                      ),
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
          ),
        ));
  }
}

List<DropdownMenuItem<String>> _themeList(
    List<String> options, TextStyle textStyle) {
  return options.map<DropdownMenuItem<String>>((String option) {
    return DropdownMenuItem<String>(
      value: option,
      child: Text(option, style: textStyle),
    );
  }).toList();
}
