import 'package:flutter/material.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';

import '../../ui_constants/colors.dart';

class ConditionerInfoColumn extends StatelessWidget {
  late final Conditioner conditioner;
  late final TextStyle style;
  final Color? color;

  ConditionerInfoColumn({
    required this.conditioner,
    required this.style,
    this.color
  });

  final Color mainBlack = CinimexColors.mainBlack;
  final MainAxisAlignment columnAlignment = MainAxisAlignment.center;
  final MainAxisAlignment rowAlignment = MainAxisAlignment.spaceBetween;

  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: columnAlignment,
        children: [
          Row(
            mainAxisAlignment: rowAlignment,
            children: [
              _getIconStatus(conditioner.status, color),
              Text(conditioner.temperature, style: style),
            ],
          ),
          Row(
            mainAxisAlignment: rowAlignment,
            children: [
              Icon(Icons.access_time, color: color),
              Text(conditioner.whereUpdated, style: style),
            ],
          ),
          Row(
            mainAxisAlignment: rowAlignment,
            children: [
              Icon(Icons.badge_outlined, color: color),
              Text(conditioner.userName, style: style)
            ],
          ),
        ],
      ),
    );
  }
}

Icon _getIconStatus(ConditionerStatus status, Color? color) {
  switch (status) {
    case ConditionerStatus.undefined:
      return Icon(Icons.leak_remove, color: color);
    case ConditionerStatus.off:
      return Icon(Icons.flash_off, color: color);
    case ConditionerStatus.auto:
      return Icon(Icons.auto_fix_high, color: color);
    case ConditionerStatus.fan:
      return Icon(Icons.air_outlined, color: color);
    case ConditionerStatus.cold17:
      return Icon(Icons.ac_unit, color: color);
    case ConditionerStatus.cold22:
      return Icon(Icons.ac_unit_outlined, color: color);
    case ConditionerStatus.hot30:
      return Icon(Icons.local_fire_department, color: color);
    default:
      return Icon(Icons.no_accounts, color: color);
  }
}