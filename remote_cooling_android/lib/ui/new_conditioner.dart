import 'package:flutter/material.dart';

class NewConditionerPage extends StatefulWidget {
  @override
  _NewConditionerState createState() => _NewConditionerState();
}

class _NewConditionerState extends State<NewConditionerPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
      appBar: AppBar(
        title: Text('Добавить кондиционер'),
      ),

      body: Builder(
        builder: (ctx) => Column(
          children: [

          ],
        ),
      ),
    ),
    onWillPop: () {
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
      return Future.value(false);
    });
  }
}