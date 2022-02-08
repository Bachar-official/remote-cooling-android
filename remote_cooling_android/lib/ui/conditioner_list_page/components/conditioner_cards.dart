import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:skeletons/skeletons.dart';

import 'conditioner_card.dart';

class ConditionerCards extends StatelessWidget {
  late final List<Conditioner> conditioners;
  late final Function callback;
  late final isLoading;

  ConditionerCards({
    required this.conditioners,
    required this.callback,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      skeleton: SkeletonListView(
          item: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  height: 120,
                )
            ),
          )
      ),
      child: conditioners.length == 0
      ? SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
                child: Text(
                    'Устройств в вашей подсети не найдено.\n' +
                        'Попробуйте повторить поиск или проверьте настройки сети.',
                    textAlign: TextAlign.center)),
          ))
      : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: conditioners.length,
        itemBuilder: (context, index) {
          return ConditionerCard(
              conditioner: conditioners[index], callback: callback);
        },
      ),
    );
  }
}
