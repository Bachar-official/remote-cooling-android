import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class EmptyNameDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Необходимо изменить имя пользователя, чтобы использовать данное приложение.\nНажмие "ОК", чтобы зайти в Настройки.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => RouteUtils.goToPage(context, AppRouter.settingsPage, null, () => {}),
          child: const Text('OK'),
        )
      ],
    );
  }
}