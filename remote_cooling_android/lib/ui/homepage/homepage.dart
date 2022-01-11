import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/domain/model/conditioner-list-model.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/ui/navbar.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

import 'components/conditioner-cards.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerListModel>(context, listen: true);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Cinimex Охлаждайка'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                provider.getConditioners();
              }),
        ],
      ),
      body: Center(
        child: provider.isLoading ?
        CircularProgressIndicator(color: Constants.mainOrange) :
        Consumer<ConditionerListModel>(
          builder: (context, model, child) => Center(
            child: ConditionerCards(
              conditioners: model.conditioners,
                callback: () => {}
            )
          ),
        )
      ),
    );
  }
}
