import 'package:flutter/material.dart';

class RouteUtils {
  static void goToPage(context, path, {dynamic prop, Function? callback}) {
    Navigator.pushNamed(context, path, arguments: prop).then((value) => {
      if (callback != null) {
        callback(),
      }
    });
  }

  static void showNotification(BuildContext context, String message, Color color) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}