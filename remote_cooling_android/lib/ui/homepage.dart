import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/ui/navbar.dart';
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
          color: Constants.mainOrange,
      child: Row(children: [
        Text(title, style:
        TextStyle(fontSize: 20, color: Constants.mainBlack),
        ),
        Spacer(),
        Icon(Icons.ac_unit, color: Constants.mainBlack,),
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
      drawer: NavBar(),
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