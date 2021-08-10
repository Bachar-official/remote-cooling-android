import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

SizedBox generateCard(String title) {
    return SizedBox(
      height: 80,
      child: Card(
      child: Row(children: [
        Text(title, style: TextStyle(fontSize: 20,),),
        Spacer(),
        Icon(Icons.ac_unit),
      ],),
    ));
  }

class _HomepageState extends State<Homepage> {  

  List<SizedBox> conditioners = [
    generateCard('Кухня'),
    generateCard('Переговорка'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cinimex Охлаждайка'),
      ),
      body: Builder(
        builder: (ctx) => Column(
          children: conditioners,
        ),
      ),
    );
  }
}