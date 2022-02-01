import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/cinimex-colors.dart';
import 'package:remote_cooling_android/domain/model/conditioner-list-model.dart';
import 'package:remote_cooling_android/domain/model/conditioner-model.dart';

import 'components/conditioner-body.dart';

class ConditionerPage extends StatefulWidget {
  @override
  _ConditionerState createState() => _ConditionerState();
}

class _ConditionerState extends State<ConditionerPage> {
  late bool on;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerModel>(context, listen: true);
    var changeCallback =
        Provider.of<ConditionerListModel>(context, listen: false)
            .changeConditioner;
    provider.setCallback(changeCallback);
    bool isLoading = provider.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          provider.conditioner.name,
          style: TextStyle(fontFamily: 'Europe'),
        ),
      ),
      body: Consumer<ConditionerModel>(
          builder: (context, model, child) => ConditionerBody(
                isLoading: isLoading,
                conditioner: provider.conditioner,
                setMode: provider.setMode,
                isOn: provider.isOn,
                setOnOff: provider.switchOnOff,
              )),
    );
  }
}
