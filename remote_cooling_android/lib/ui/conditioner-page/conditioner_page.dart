import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/domain/model/conditioner-model.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';

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

    on = provider.isOn;
    bool isLoading = provider.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.conditioner.name),
        actions: [
          isLoading
              ? Icon(Icons.watch_later_outlined, color: Constants.mainOrange)
              : Switch(
                  value: on,
                  onChanged: (value) {
                    provider.switchOnOff(value);
                  }),
        ],
      ),
      body: Consumer<ConditionerModel>(
        builder: (context, model, child) => ConditionerBody(
            isLoading: isLoading,
            conditioner: provider.conditioner,
            setMode: provider.setMode)
      ),
    );
  }
}


