import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О программе'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Cinimex Cooling v.1.2.1'),
            Text('Разработчик: Иван Бачарников'),
            Text('(ibacharnikov@cinimex.ru)'),
            Text('github: https://github.com/Bachar_official')
          ],
        ),
      ),
    );
  }
}