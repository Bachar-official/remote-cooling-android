import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/utils/route-utils.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: _items(), onTap: (value) => _onItemTapped(value, context));
  }

  List<BottomNavigationBarItem> _items() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
      BottomNavigationBarItem(
          icon: Icon(Icons.add_to_home_screen), label: 'О программе'),
    ];
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        RouteUtils.goToPage(context, AppRouter.homepage);
        break;
      case 1:
        RouteUtils.goToPage(context, AppRouter.settingsPage);
        break;
      case 2:
        RouteUtils.goToPage(context, AppRouter.aboutPage);
        break;
    }
  }
}
