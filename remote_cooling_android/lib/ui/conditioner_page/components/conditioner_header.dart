import 'package:flutter/cupertino.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:skeletons/skeletons.dart';

class ConditionerHeader extends StatelessWidget {
  late final Conditioner conditioner;
  late final bool isLoading;

  ConditionerHeader(
      {required this.conditioner, required this.isLoading});

  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: FittedBox(
            child: Text(
              conditioner.temperature,
              style: TextStyle(fontSize: 100),
            ),
          ),
        ),
      ),
      skeleton: SkeletonLine(
        style: SkeletonLineStyle(
          alignment: Alignment.center,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          height: 100,
          width: 200
        ),
      ),
    );
  }
}
