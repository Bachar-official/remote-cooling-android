import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/ui/navbar.dart';
import 'package:remote_cooling_android/utils/renderUtils.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

List<Conditioner> getConditioners(BuildContext context) {
  List<Conditioner> result = [];
  result.add(Conditioner(
    'Кухня', '/kitchen', ConditionerStatus.off, DateTime.now()
  ));
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
          children: [],
        ),
      ),
    );
  }
}