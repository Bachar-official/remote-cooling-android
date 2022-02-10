import 'package:flutter/material.dart';

class EmptyNameDialog extends StatelessWidget {
  late final Function openSettings;
  final int settingsIndex = 1;

  EmptyNameDialog({required this.openSettings});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Необходимо изменить имя пользователя, чтобы использовать данное приложение.\nНажмие "ОК", чтобы зайти в Настройки.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => openSettings(settingsIndex),
          child: const Text('OK'),
        )
      ],
    );
  }
}