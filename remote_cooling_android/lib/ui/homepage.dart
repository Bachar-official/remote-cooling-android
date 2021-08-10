import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

SizedBox generateCard(String title, BuildContext context) {
    return SizedBox(
      height: 80,
      child: GestureDetector(
        onTap: () => RouteUtils.goToPage(context, AppRouter.conditionerPage, null),
        child: Card(
      child: Row(children: [
        Text(title, style: TextStyle(fontSize: 20,),),
        Spacer(),
        Icon(Icons.ac_unit),
      ],
      ),
    )));
  }

List<SizedBox> getConditioners(BuildContext context) {
  List<SizedBox> result = [];
  result.add(generateCard('Кухня', context));
  result.add(generateCard('Переговорка', context));
  return result;
}

class _HomepageState extends State<Homepage> {  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cinimex Охлаждайка'),
      ),
      body: Builder(
        builder: (ctx) => Column(
          children: getConditioners(ctx),
        ),
      ),
    );
  }
}