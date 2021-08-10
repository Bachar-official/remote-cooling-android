import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(child: ListView(
        children: [
          ElevatedButton.icon(
            onPressed: () => {},
            icon: Icon(Icons.settings),
            label: Text('Настройки')),
          
          ElevatedButton.icon(
            onPressed: () => {
              RouteUtils.goToPage(context, AppRouter.aboutPage, null),
            },
            icon: Icon(Icons.add_to_home_screen),
            label: Text('О программе')),
        ],
      ),
    ));
  }
}