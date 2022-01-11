import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О программе'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Text('Cinimex Cooling v.0.3.0'),
              Text('Разработчик: Иван Бачарников'),
              Text('Email: ibacharnikov@cinimex.ru'),
              Text('Github: https://github.com/Bachar_official'),
              Text('Telegram: @Bachar-official')
            ],
          ),
        ),
      ),
    );
  }
}