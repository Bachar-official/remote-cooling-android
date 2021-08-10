import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ElevatedButton.icon(
            onPressed: () => {},
            icon: Icon(Icons.settings),
            label: Text('Настройки'))
        ],
      ),
    );
  }
}