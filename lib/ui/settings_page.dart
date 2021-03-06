import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/view_model/settings_view_model.dart';
import 'package:remote_cooling_android/ui/ui_constants/theme.dart';
import 'package:remote_cooling_android/utils/route_utils.dart';
import 'package:remote_cooling_android/utils/validation_utils.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
                        initialValue: model.userName,
                        decoration: const InputDecoration(
                            labelText: 'Имя пользователя'),
                        validator: ValidationUtils.validateEnglish,
                        onChanged: (newUser) => model.setUserName(newUser)),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: model.port.toString(),
                        decoration: const InputDecoration(labelText: 'Порт'),
                        validator: ValidationUtils.validatePort,
                        onChanged: (newPort) => {
                          model.setPort(int.parse(newPort)),
                            }),
                    TextFormField(
                        initialValue: model.command,
                        decoration: const InputDecoration(
                            labelText: 'Команда для сканирования'),
                        validator: ValidationUtils.validateNull,
                        onChanged: (newCommand) =>
                            model.setPingCommand(newCommand)),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: model.duration.toString(),
                        decoration: const InputDecoration(
                            labelText: 'Длительность ожидания (сек.)'),
                        validator: ValidationUtils.validateDuration,
                        onChanged: (newDuration) => {
                              if (newDuration == '')
                                {
                                  model.setDuration(0),
                                }
                              else
                                model.setDuration(int.parse(newDuration))
                            }),
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Тема оформления'),
                      isExpanded: true,
                      value: model.themeName,
                      items: _themeList(themeDictionary.keys.toList()),
                      onChanged: (value) => model.setTheme(value!),
                    ),

                    Row(
                      mainAxisAlignment: rowAlignment,
                      children: [
                        Tooltip(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Режим разработчика',
                                  style: TextStyle(fontSize: 14, decoration: TextDecoration.underline)),
                              const Icon(Icons.info_outline, size: 10)
                            ],
                          ),
                          message: 'Показывает API кондиционера',
                          showDuration: Duration(seconds: 3),
                          triggerMode: TooltipTriggerMode.tap,
                        ),
                        Checkbox(
                            //activeColor: Constants.mainOrange,
                            value: model.isDeveloper,
                            onChanged: (value) => model.setDeveloper(value)),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            model.storeSettings();
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
