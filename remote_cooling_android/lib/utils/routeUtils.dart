import 'package:flutter/material.dart';

class RouteUtils {
  static void goToPage(context, path, param, Function callback) {
    Navigator.pushNamed(context, path, arguments: param).then((value) => {callback()});
  }

  static void showNotification(BuildContext context, String message, Color color) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}