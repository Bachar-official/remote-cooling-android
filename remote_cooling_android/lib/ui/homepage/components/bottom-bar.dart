import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/utils/route-utils.dart';

class BottomBar extends StatelessWidget {
  late final int pageNumber;
  late final Function onPageChanged;

  BottomBar({required this.pageNumber, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageNumber,
        items: _items(), onTap: (value) => onPageChanged(value));
  }

  List<BottomNavigationBarItem> _items() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
      BottomNavigationBarItem(
          icon: Icon(Icons.add_to_home_screen), label: 'О программе'),
    ];
  }
}
