import 'package:flutter/cupertino.dart';
import 'package:skeletons/skeletons.dart';

class ConditionerListSkeleton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SkeletonListView(
      item: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SkeletonLine(
          style: SkeletonLineStyle(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            height: 120,
          )
        ),
      )
    );
  }
}