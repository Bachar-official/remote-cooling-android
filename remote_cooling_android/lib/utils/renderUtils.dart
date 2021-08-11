import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';
import 'package:remote_cooling_android/utils/time_ago.dart';

import '../constants.dart';

class RenderUtils {
  static Icon getIconStatus(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.undefined:
        return Icon(Icons.leak_remove, color: Constants.mainBlack);
      case ConditionerStatus.off:
        return Icon(Icons.flash_off, color: Constants.mainBlack);
      default:
        return null;
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

  static List<SizedBox> renderConditioners(
      List<Conditioner> conditioners, BuildContext context) {
    List<SizedBox> result = [];
    conditioners.forEach((conditioner) {
      result.add(generateCard(conditioner, context));
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
    switch(status) {
      case ConditionerStatus.off: return 'выключен';
      case ConditionerStatus.undefined: return 'нет связи';
    }
  }

  static Row getStatus(Conditioner conditioner) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Статус: '),
      Text(getStringStatus(conditioner.status)),
    ],);
  }

  static Row getEndpoint(Conditioner conditioner) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('API: '),
      Text(conditioner.endpoint),
    ],);
  }

  static QrImage generateImage(conditionerData) {
    return QrImage(
      backgroundColor: Colors.white,
      data: conditionerData.toString(),
      version: QrVersions.auto,
      size: 200.0,
      );
  }

  static AlertDialog renderAlert(
    String title, double width, double height, List<Widget> content, List<Widget> actions
    ) {
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
}
