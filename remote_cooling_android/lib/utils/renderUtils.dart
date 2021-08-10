import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

import '../constants.dart';

class RenderUtils {

  static Icon getIconStatus(ConditionerStatus status) {
    switch(status) {
      case ConditionerStatus.undefined: return Icon(Icons.leak_remove, color: Constants.mainBlack);
      case ConditionerStatus.off: return Icon(Icons.flash_off, color: Constants.mainBlack);
      default: return null;
    }
  }

  static SizedBox generateCard(Conditioner conditioner, BuildContext context) {
    return SizedBox(
        height: 60,
        child: GestureDetector(
            onTap: () => RouteUtils.goToPage(
                context, AppRouter.conditionerPage, conditioner),
            child: Card(
              color: Constants.mainOrange,
              child: Row(
                children: [
                  Text(
                    conditioner.name,
                    style: TextStyle(fontSize: 20, color: Constants.mainBlack),
                  ),
                  Spacer(),
                  getIconStatus(conditioner.status),
                ],
              ),
            )));
  }

  static List<SizedBox> renderConditioners(List<Conditioner> conditioners, BuildContext context) {
    List<SizedBox> result = [];
    conditioners.forEach((conditioner) {
      result.add(generateCard(conditioner, context));
    });
    return result;
  }
}
