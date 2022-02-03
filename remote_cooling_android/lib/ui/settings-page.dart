import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/view-model/settings-view-model.dart';
import 'package:remote_cooling_android/entities/theme.dart';
import 'package:remote_cooling_android/utils/route-utils.dart';
import 'package:remote_cooling_android/utils/validation-utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var provider = Provider.of<SettingsViewModel>(context, listen: false);
    final MainAxisAlignment rowAlignment = MainAxisAlignment.spaceBetween;

    return Consumer<SettingsViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Builder(
          builder: (ctx) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                        initialValue: provider.userName,
                        decoration: const InputDecoration(
                            labelText: 'Имя пользователя'),
                        validator: ValidationUtils.validateEnglish,
                        onChanged: (newUser) => provider.setUserName(newUser)),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: provider.port.toString(),
                        decoration: const InputDecoration(labelText: 'Порт'),
                        validator: ValidationUtils.validatePort,
                        onChanged: (newPort) => {
                              provider.setPort(int.parse(newPort)),
                            }),
                    TextFormField(
                        initialValue: provider.command,
                        decoration: const InputDecoration(
                            labelText: 'Команда для сканирования'),
                        validator: ValidationUtils.validateNull,
                        onChanged: (newCommand) =>
                            provider.setPingCommand(newCommand)),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: provider.duration.toString(),
                        decoration: const InputDecoration(
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
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Тема оформления'),
                      isExpanded: true,
                      value: provider.themeName,
                      items: _themeList(themeDictionary.keys.toList()),
                      onChanged: (value) => provider.setTheme(value!),
                    ),
                    Row(
                      mainAxisAlignment: rowAlignment,
                      children: [
                        Tooltip(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Режим разработчика',
                                  style: TextStyle(fontSize: 15)),
                              const Icon(Icons.info_outline, size: 10)
                            ],
                          ),
                          message: 'Показывает API кондиционера',
                          showDuration: Duration(seconds: 3),
                          triggerMode: TooltipTriggerMode.tap,
                        ),
                        Checkbox(
                            //activeColor: Constants.mainOrange,
                            value: provider.isDeveloper,
                            onChanged: (value) => provider.setDeveloper(value)),
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
                        child: const Text('Сохранить'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> _themeList(List<String> options) {
  return options.map<DropdownMenuItem<String>>((String option) {
    return DropdownMenuItem<String>(
      value: option,
      child: Text(option),
    );
  }).toList();
}
