import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/view-model/conditioner-view-model.dart';
import 'package:remote_cooling_android/domain/view-model/settings-view-model.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';

import '../../../cinimex-colors.dart';
import 'conditioner-footer.dart';
import 'conditioner-mode-chooser.dart';

class ConditionerBody extends StatelessWidget {
  late final bool isLoading;
  late final Conditioner conditioner;
  late final Function setMode;
  late final Function setOnOff;
  late final bool isOn;

  ConditionerBody(
      {required this.isLoading,
        required this.conditioner,
        required this.setMode,
        required this.setOnOff,
        required this.isOn
      });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerViewModel>(context, listen: true);
    bool isDeveloper = Provider.of<SettingsViewModel>(context, listen: false).isDeveloper;
    return Column(
        children: isLoading
            ? [
          Center(
              child:
              CircularProgressIndicator(color: CinimexColors.mainOrange))
        ]
            : [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: FittedBox(
                child: Text(
                  provider.temperature,
                  style: TextStyle(fontSize: 100),
                ),
              ),
            ),
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Switch(
                value: isOn,
                onChanged: (value) => setOnOff(value),
              ),
              Container(width: 18),
              Text(isOn ? 'включён' : 'выключен', style: TextStyle(fontSize: 17))
            ],
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
          ConditionerFooter(conditioner: conditioner, isDeveloper: isDeveloper)
        ]);
  }
}