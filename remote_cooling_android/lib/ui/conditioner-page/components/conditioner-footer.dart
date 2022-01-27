import 'package:flutter/cupertino.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/utils/time_ago.dart';

class ConditionerFooter extends StatelessWidget {
  late final Conditioner conditioner;
  late final bool isDeveloper;

  ConditionerFooter({required this.conditioner, required this.isDeveloper});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isDeveloper ? Text('API: ${conditioner.endpoint}') : Text(''),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Обновлено: '),
          Text(TimeAgo.timeAgoSinceDate(conditioner.updatedAt)),
          Text(' пользователем ${conditioner.userName}')
        ])
      ],
    );
  }
}
