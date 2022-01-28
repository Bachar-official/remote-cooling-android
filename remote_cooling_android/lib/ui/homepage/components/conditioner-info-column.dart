import 'package:flutter/material.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';

import '../../../constants.dart';

class ConditionerInfoColumn extends StatelessWidget {
  late final provider;

  ConditionerInfoColumn({required this.provider});

  final TextStyle textStyle = TextStyle(color: Constants.mainBlack, fontSize: 18);
  final Color mainBlack = Constants.mainBlack;
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
              _getIconStatus(provider.conditioner.status, mainBlack),
              Text(provider.temperature, style: textStyle,),
            ],
          ),
          Row(
            mainAxisAlignment: rowAlignment,
            children: [
              Icon(Icons.access_time, color: mainBlack),
              Text(provider.updatedWhile, style: textStyle),
            ],
          ),
          Row(
            mainAxisAlignment: rowAlignment,
            children: [
              Icon(Icons.badge_outlined, color: mainBlack),
              Text(provider.conditioner.userName, style: textStyle)
            ],
          ),
        ],
      ),
    );
  }
}

Icon _getIconStatus(ConditionerStatus status, Color color) {
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
      return Icon(Icons.no_accounts);
  }
}