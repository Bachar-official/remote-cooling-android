import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';
import 'package:remote_cooling_android/utils/time_ago.dart';
import 'package:remote_cooling_android/constants.dart';

class RenderUtils {
  static Icon getIconStatus(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.undefined:
        return Icon(Icons.leak_remove, color: Constants.mainBlack);
      case ConditionerStatus.off:
        return Icon(Icons.flash_off, color: Constants.mainBlack);
      case ConditionerStatus.on:
        return Icon(Icons.flash_on, color: Constants.mainBlack);
      default:
        return null;
    }
  }

  static List<SizedBox> renderCards(
      List<Conditioner> conditioners, BuildContext context, Function callback) {
    List<SizedBox> result = [];
    if (conditioners == null) {
      return result;
    } else {
      for (Conditioner conditioner in conditioners) {
        result.add(generateCard(conditioner, context, callback));
      }
    }

    return result;
  }

  static SizedBox generateCard(
      Conditioner conditioner, BuildContext context, Function callback) {
    return SizedBox(
        height: 60,
        child: GestureDetector(
            onTap: () => RouteUtils.goToPage(
                context, AppRouter.conditionerPage, conditioner, callback),
            child: Card(
              color: Constants.mainOrange,
              child: Row(
                children: [
                  conditioner.name == null
                      ? Text('')
                      : Text(
                          conditioner.name,
                          style: TextStyle(
                              fontSize: 20, color: Constants.mainBlack),
                        ),
                  Spacer(),
                  getIconStatus(conditioner.status),
                ],
              ),
            )));
  }

  static List<SizedBox> renderConditioners(
      List<Conditioner> conditioners, BuildContext context, Function callback) {
    List<SizedBox> result = [];
    conditioners.forEach((conditioner) {
      result.add(generateCard(conditioner, context, callback));
    });
    return result;
  }

  static Row getUpdated(Conditioner conditioner) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Обновлено: '),
      Text(TimeAgo.timeAgoSinceDate(conditioner.updatedAt)),
    ]);
  }

  static String getStringStatus(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.off:
        return 'выключен';
      case ConditionerStatus.undefined:
        return 'нет связи';
      case ConditionerStatus.on:
        return 'включён';
      default:
        return 'нет связи';
    }
  }

  static Row getStatus(Conditioner conditioner) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Статус: '),
        Text(getStringStatus(conditioner.status)),
      ],
    );
  }

  static Row getEndpoint(Conditioner conditioner) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('API: '),
        Text(conditioner.endpoint),
      ],
    );
  }

  static AlertDialog renderAlert(String title, double width, double height,
      List<Widget> content, List<Widget> actions) {
    return AlertDialog(
      title: Text(title),
      content: Container(
        width: width,
        height: height,
        child: Column(
          children: content,
        ),
      ),
      actions: actions,
    );
  }

  static bool isConditionerOn(Conditioner conditioner) {
    switch (conditioner.status) {
      case ConditionerStatus.off:
        return false;
      case ConditionerStatus.on:
        return true;
      default:
        return false;
    }
  }
}
