import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

import '../../../constants.dart';

class ConditionerCard extends StatelessWidget {
  late final Conditioner conditioner;
  late final Function callback;

  ConditionerCard({required this.conditioner, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: GestureDetector(
          onTap: () => RouteUtils.goToPage(
              context, AppRouter.conditionerPage, conditioner, callback),
          child: Card(
            color: Constants.mainOrange,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  conditioner.name.isEmpty
                      ? Text('')
                      : Text(
                          conditioner.name,
                          style:
                              TextStyle(fontSize: 20, color: Constants.mainBlack),
                        ),
                  Spacer(),
                  _getIconStatus(conditioner.status),
                ],
              ),
            ),
          )),
    );
  }
}

Icon _getIconStatus(ConditionerStatus status) {
  switch (status) {
    case ConditionerStatus.undefined:
      return Icon(Icons.leak_remove, color: Constants.mainBlack);
    case ConditionerStatus.off:
      return Icon(Icons.flash_off, color: Constants.mainBlack);
    case ConditionerStatus.auto:
      return Icon(Icons.auto_fix_high, color: Constants.mainBlack);
    case ConditionerStatus.fan:
      return Icon(Icons.waves, color: Constants.mainBlack);
    case ConditionerStatus.cold17:
      return Icon(Icons.ac_unit, color: Constants.mainBlack);
    case ConditionerStatus.cold22:
      return Icon(Icons.ac_unit_outlined, color: Constants.mainBlack);
    case ConditionerStatus.hot30:
      return Icon(Icons.local_fire_department, color: Constants.mainBlack);
    default:
      return Icon(Icons.no_accounts);
  }
}
