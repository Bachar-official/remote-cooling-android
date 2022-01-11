import 'package:flutter/cupertino.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';

import 'conditioner-card.dart';

class ConditionerCards extends StatelessWidget {
  late final List<Conditioner> conditioners;
  late final Function callback;

  ConditionerCards({required this.conditioners, required this.callback});

  @override
  Widget build(BuildContext context) {
    if (conditioners.length == 0) {
      return SizedBox(
          child: Center(
              child: Text('Устройств в вашей подсети не найдено.\n' +
                  'Попробуйте повторить поиск или проверьте настройки сети.')));
    }
    return ListView.builder(
      itemCount: conditioners.length,
      itemBuilder: (context, index) {
        return ConditionerCard(
            conditioner: conditioners[index],
            callback: callback);
      },
    );
  }
}