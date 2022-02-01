import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/domain/model/conditioner-model.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/utils/route-utils.dart';

import '../../../cinimex-colors.dart';
import 'conditioner-info-column.dart';

class ConditionerCard extends StatelessWidget {
  late final Conditioner conditioner;
  late final Function callback;

  ConditionerCard({required this.conditioner, required this.callback});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerModel>(context, listen: true);
    provider.setConditioner(conditioner);
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
                  provider.conditioner.name.isEmpty
                      ? Text('')
                      : Text(
                          provider.conditioner.name,
                          style:
                              TextStyle(fontSize: 20, color: CinimexColors.mainBlack),
                        ),
                  Spacer(),
                  VerticalDivider(
                    color: CinimexColors.mainBlack,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  ConditionerInfoColumn(provider: provider),
                ],
              ),
            ),
          )),
    );
  }
}