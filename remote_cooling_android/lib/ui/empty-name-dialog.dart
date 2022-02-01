import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/utils/route-utils.dart';

class EmptyNameDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Необходимо изменить имя пользователя, чтобы использовать данное приложение.\nНажмие "ОК", чтобы зайти в Настройки.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => RouteUtils.goToPage(context, AppRouter.settingsPage),
          child: const Text('OK'),
        )
      ],
    );
  }
}