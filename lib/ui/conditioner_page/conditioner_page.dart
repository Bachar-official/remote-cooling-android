import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/view_model/conditioner_list_view_model.dart';
import 'package:remote_cooling_android/domain/view_model/conditioner_view_model.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';

import 'components/conditioner_body.dart';

class ConditionerPage extends StatefulWidget {
  @override
  _ConditionerState createState() => _ConditionerState();
}

class _ConditionerState extends State<ConditionerPage> {
  late bool on;

  @override
  Widget build(BuildContext context) {
    Conditioner conditioner = ModalRoute.of(context)!.settings.arguments as Conditioner;
    var provider = Provider.of<ConditionerViewModel>(context, listen: true);
    var changeCallback =
        Provider.of<ConditionerListViewModel>(context, listen: false)
            .changeConditioner;
    provider.setCallback(changeCallback);
    provider.setConditioner(conditioner);
    bool isLoading = provider.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          provider.conditioner.name,
          style: TextStyle(fontFamily: 'Europe'),
        ),
      ),
      body: Consumer<ConditionerViewModel>(
          builder: (context, model, child) => ConditionerBody(
                isLoading: isLoading,
                conditioner: provider.conditioner,
                setMode: provider.setMode,
                setOnOff: provider.switchOnOff,
              )),
    );
  }
}
