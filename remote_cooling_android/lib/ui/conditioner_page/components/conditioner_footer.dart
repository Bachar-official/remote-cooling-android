import 'package:flutter/cupertino.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/utils/time_ago.dart';
import 'package:skeletons/skeletons.dart';

class ConditionerFooter extends StatelessWidget {
  late final Conditioner conditioner;
  late final bool isDeveloper;
  late final bool isLoading;

  ConditionerFooter({
    required this.conditioner,
    required this.isDeveloper,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      skeleton: Column(
        children: [
          isDeveloper ? textSkeleton : SizedBox.shrink(),
          textSkeleton
        ],
      ),
      child: Column(
        children: [
          isDeveloper ? Text('API: ${conditioner.endpoint}') : SizedBox.shrink(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Обновлено '),
            Text(TimeAgo.timeAgoSinceDate(conditioner.updatedAt)),
          ])
        ],
      ),
    );
  }

  Widget textSkeleton = Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
  child: SkeletonLine(
    style: SkeletonLineStyle(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      alignment: Alignment.center,
      width: 220,
      height: 10
    ),
  ),);
}
