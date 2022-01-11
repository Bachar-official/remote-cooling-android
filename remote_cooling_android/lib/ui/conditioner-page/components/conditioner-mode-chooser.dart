import 'package:flutter/material.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';

class ConditionerModeChooser extends StatelessWidget {
  late final Conditioner conditioner;
  late final Function onChange;

  ConditionerModeChooser(
      {required this.conditioner, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(_getStringStatus(ConditionerStatus.auto)),
          leading: Radio(
              value: ConditionerStatus.auto,
              groupValue: conditioner.status,
              onChanged: (value) {
                onChange(value);
              }),
        ),
        ListTile(
          title: Text(_getStringStatus(ConditionerStatus.cold17)),
          leading: Radio(
              value: ConditionerStatus.cold17,
              groupValue: conditioner.status,
              onChanged: (value) {
                onChange(value);
              }),
        ),
        ListTile(
          title: Text(_getStringStatus(ConditionerStatus.cold22)),
          leading: Radio(
              value: ConditionerStatus.cold22,
              groupValue: conditioner.status,
              onChanged: (value) {
                onChange(value);
              }),
        ),
        ListTile(
          title: Text(_getStringStatus(ConditionerStatus.hot30)),
          leading: Radio(
              value: ConditionerStatus.hot30,
              groupValue: conditioner.status,
              onChanged: (value) {
                onChange(value);
              }),
        ),
        ListTile(
          title: Text(_getStringStatus(ConditionerStatus.fan)),
          leading: Radio(
              value: ConditionerStatus.fan,
              groupValue: conditioner.status,
              onChanged: (value) {
                onChange(value);
              }),
        ),
      ],
    );
  }
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