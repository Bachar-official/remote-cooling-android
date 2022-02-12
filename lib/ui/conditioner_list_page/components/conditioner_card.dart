import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/utils/route_utils.dart';

import '../../ui_constants/colors.dart';
import 'conditioner_info_column.dart';

class ConditionerCard extends StatelessWidget {
  late final Conditioner conditioner;
  late final Function callback;

  ConditionerCard({required this.conditioner, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: GestureDetector(
          onTap: () => RouteUtils.goToPage(
              context, AppRouter.conditionerPage, prop: conditioner),
          child: Card(
            color: CinimexColors.mainOrange,
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
                          style:
                          TextStyle(fontSize: 30, color: CinimexColors.mainBlack),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: CinimexColors.mainBlack,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  ConditionerInfoColumn(conditioner: conditioner),
                ],
              ),
            ),
          )),
    );
  }
}