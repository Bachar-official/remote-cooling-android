import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/model/conditioner-model.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';

import '../../../constants.dart';
import 'conditioner-footer.dart';
import 'conditioner-mode-chooser.dart';

class ConditionerBody extends StatelessWidget {
  late final bool isLoading;
  late final Conditioner conditioner;
  late final Function setMode;

  ConditionerBody(
      {required this.isLoading,
        required this.conditioner,
        required this.setMode});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerModel>(context, listen: true);
    return Column(
        children: isLoading
            ? [
          Center(
              child:
              CircularProgressIndicator(color: Constants.mainOrange))
        ]
            : [
          Text(
            provider.temperature,
            style: TextStyle(fontSize: 100),
          ),
          Text(
            provider.stringMode,
            style: TextStyle(fontSize: 60),
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          ConditionerModeChooser(
              conditioner: conditioner, onChange: setMode),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Spacer(),
          ConditionerFooter(conditioner: conditioner)
        ]);
  }
}