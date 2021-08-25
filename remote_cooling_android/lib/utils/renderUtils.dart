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
      case ConditionerStatus.auto:
        return Icon(Icons.auto_fix_high, color: Constants.mainBlack);
      case ConditionerStatus.fan:
        return Icon(Icons.waves, color: Constants.mainBlack);
      case ConditionerStatus.cold17:
        return Icon(Icons.ac_unit, color: Constants.mainBlack);
      case ConditionerStatus.cold22:
        return Icon(Icons.ac_unit_outlined, color: Constants.mainBlack);
      default:
        return null;
    }
  }

  static List<SizedBox> renderCards(
      List<Conditioner> conditioners, BuildContext context, Function callback) {
    List<SizedBox> result = [];
    if (conditioners == null || conditioners.length == 0) {
      result.add(SizedBox(
        child: Center(child: Text('Устройств в вашей подсети не найдено.\n'+
        'Попробуйте повторить поиск или проверьте настройки сети.'))
      ));
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
      case ConditionerStatus.cold17:
        return 'охлаждение, 17°С';
      case ConditionerStatus.cold22:
        return 'охлаждение, 22°С';
      case ConditionerStatus.fan:
        return 'проветривание';
      case ConditionerStatus.auto:
        return 'авто';
      default:
        return 'нет связи';
    }
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

  static String getTemperature(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.auto:
        return '--';
      case ConditionerStatus.cold17:
        return '17°С';
      case ConditionerStatus.cold22:
        return '22°С';
      case ConditionerStatus.fan:
        return '--';
      case ConditionerStatus.off:
        return '--';
      case ConditionerStatus.undefined: default:
        return '--';
    }
  }

  static String getMode(ConditionerStatus status) {
    switch (status) {
      case ConditionerStatus.auto:
        return 'автоматически';
      case ConditionerStatus.cold17:
      case ConditionerStatus.cold22:
        return 'охлаждение';
      case ConditionerStatus.fan:
        return 'проветривание';
      case ConditionerStatus.off:
        return 'выключен';
      case ConditionerStatus.undefined: default:
        return '-';
    }
  }

  static Column getStatus(Conditioner conditioner) {
    return Column(
      children: [
        Text(
          getTemperature(conditioner.status),
          style: TextStyle(fontSize: 100),
        ),
        Text(
          getMode(conditioner.status),
          style: TextStyle(fontSize: 60),
        ),
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
      case ConditionerStatus.auto:
      case ConditionerStatus.cold17:
      case ConditionerStatus.cold22:
      case ConditionerStatus.fan:
        return true;
      default:
        return false;
    }
  }

  static Column renderModeChoose(Conditioner conditioner, Function onChange) {
    return Column(
      children: [
        ListTile(
          title: Text(getStringStatus(ConditionerStatus.auto)),
          leading: Radio(
            value: ConditionerStatus.auto,
            groupValue: conditioner.status,
            onChanged: (value) {
              onChange(value);
            }
          ),
        ),

        ListTile(
          title: Text(getStringStatus(ConditionerStatus.cold17)),
          leading: Radio(
            value: ConditionerStatus.cold17,
            groupValue: conditioner.status,
            onChanged: (value) {
              onChange(value);
            }
          ),
        ),

        ListTile(
          title: Text(getStringStatus(ConditionerStatus.cold22)),
          leading: Radio(
            value: ConditionerStatus.cold22,
            groupValue: conditioner.status,
            onChanged: (value) {
              onChange(value);
            }
          ),
        ),

        ListTile(
          title: Text(getStringStatus(ConditionerStatus.fan)),
          leading: Radio(
            value: ConditionerStatus.fan,
            groupValue: conditioner.status,
            onChanged: (value) {
              onChange(value);
            }
          ),
        ),
      ],
    );
  }
}
