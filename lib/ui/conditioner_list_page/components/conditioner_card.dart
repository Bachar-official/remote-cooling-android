import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/domain/view_model/settings_view_model.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/ui/ui_constants/theme.dart';
import 'package:remote_cooling_android/utils/route_utils.dart';

import 'conditioner_info_column.dart';

class ConditionerCard extends StatelessWidget {
  late final Conditioner conditioner;
  late final Function callback;

  ConditionerCard({required this.conditioner, required this.callback});

  @override
  Widget build(BuildContext context) {
    String themeName = Provider.of<SettingsViewModel>(context, listen: false).themeName;
    const String cmxName = 'Cinimex';

    TextStyle textStyle = themeName == cmxName ?
    TextStyle(color: cmxBlack, fontSize: 30) :
    TextStyle(fontSize: 30);

    TextStyle columnStyle = themeName == cmxName ?
    TextStyle(color: cmxBlack, fontSize: 18) :
    TextStyle(fontSize: 18);

    Color? iconColor = themeName == cmxName ?
        cmxBlack : null;

    return SizedBox(
      height: 120,
      child: GestureDetector(
          onTap: () => RouteUtils.goToPage(
              context, AppRouter.conditionerPage, prop: conditioner),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        conditioner.name.isEmpty
                            ? Text('')
                            : Text(
                          conditioner.name,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    //color: CinimexColors.mainBlack,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                    color: iconColor
                  ),
                  ConditionerInfoColumn(
                      conditioner: conditioner,
                      style: columnStyle,
                      color: iconColor,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}