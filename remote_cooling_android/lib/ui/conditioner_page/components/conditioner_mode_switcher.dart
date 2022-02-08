import 'package:flutter/material.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/ui/conditioner_page/components/mode-title.dart';
import 'package:skeletons/skeletons.dart';

class ConditionerModeSwitcher extends StatelessWidget {
  late final Conditioner conditioner;
  late final Function onSetMode;
  late final Function onSwitchPower;
  late final bool isLoading;

  ConditionerModeSwitcher
      ({
        required this.conditioner,
        required this.onSetMode,
        required this.onSwitchPower,
        required this.isLoading,
      });

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      skeleton: Column(
        children: skeletonListTiles(),
      ),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Switch(
                  value: conditioner.isOn,
                  onChanged: (value) => onSwitchPower(value),
                ),
                Container(width: 18),
                Text(conditioner.isOn ? 'включён' : 'выключен',
                    style: TextStyle(fontSize: 17))
              ],
            ),
            ListTile(
              title: ModeTitle(
                icon: Icon(Icons.auto_fix_high),
                  title: _getStringStatus(ConditionerStatus.auto),
              ),
              leading: Radio(
                  value: ConditionerStatus.auto,
                  groupValue: conditioner.status,
                  onChanged: (value) {
                    onSetMode(value);
                  }),
            ),
            ListTile(
              title: ModeTitle(
                  icon: Icon(Icons.ac_unit_outlined),
                  title: _getStringStatus(ConditionerStatus.cold17)
              ),
              leading: Radio(
                  value: ConditionerStatus.cold17,
                  groupValue: conditioner.status,
                  onChanged: (value) {
                    onSetMode(value);
                  }),
            ),
            ListTile(
              title: ModeTitle(
                  icon: Icon(Icons.ac_unit_outlined),
                  title: _getStringStatus(ConditionerStatus.cold22)
              ),
              leading: Radio(
                  value: ConditionerStatus.cold22,
                  groupValue: conditioner.status,
                  onChanged: (value) {
                    onSetMode(value);
                  }),
            ),
            ListTile(
              title: ModeTitle(
                  icon: Icon(Icons.local_fire_department),
                  title: _getStringStatus(ConditionerStatus.hot30)),
              leading: Radio(
                  value: ConditionerStatus.hot30,
                  groupValue: conditioner.status,
                  onChanged: (value) {
                    onSetMode(value);
                  }),
            ),
            ListTile(
              title: ModeTitle(
                  icon: Icon(Icons.air_outlined),
                  title: _getStringStatus(ConditionerStatus.fan)),
              leading: Radio(
                  value: ConditionerStatus.fan,
                  groupValue: conditioner.status,
                  onChanged: (value) {
                    onSetMode(value);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> skeletonListTiles() {
  List<Widget> result = [];
  for (int i = 0; i < 6; i++) {
    result.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: SkeletonLine(
          style: SkeletonLineStyle(
            width: 500,
            height: 20,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      )
    );
  }
  return result;
}

String _getStringStatus(ConditionerStatus status) {
  switch (status) {
    case ConditionerStatus.off:
      return 'выключен';
    case ConditionerStatus.undefined:
      return 'нет связи';
    case ConditionerStatus.cold17:
      return 'охлаждение, 17°С';
    case ConditionerStatus.cold22:
      return 'охлаждение, 22°С';
    case ConditionerStatus.hot30:
      return 'обогрев, 30°С';
    case ConditionerStatus.fan:
      return 'проветривание';
    case ConditionerStatus.auto:
      return 'авто';
    default:
      return 'нет связи';
  }
}