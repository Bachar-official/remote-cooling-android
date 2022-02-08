import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/view_model/conditioner_list_view_model.dart';

import 'components/conditioner_cards.dart';
import 'components/conditioner_list_skeleton.dart';

class ConditionerListPage extends StatelessWidget {
  const ConditionerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerListViewModel>(context, listen: true);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: provider.isLoading
          ? Icon(Icons.watch_later_outlined, size: 30)
          : Icon(Icons.refresh, size: 30),
        onPressed: provider.getConditioners
      ),
      body: provider.isLoading
          ? ConditionerListSkeleton()
          : Consumer<ConditionerListViewModel>(
              builder: (context, model, child) => Center(
                  child: ConditionerCards(
                      conditioners: model.conditioners,
                      callback: () => {})),
            ),
    );
  }
}
