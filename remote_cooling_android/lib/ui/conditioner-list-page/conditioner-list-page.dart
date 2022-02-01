import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/cinimex-colors.dart';
import 'package:remote_cooling_android/domain/model/conditioner-list-model.dart';

import 'components/conditioner-cards.dart';

class ConditionerListPage extends StatelessWidget {
  const ConditionerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerListModel>(context, listen: true);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh, size: 30),
        onPressed: provider.getConditioners
      ),
      body: Center(
          child: provider.isLoading
              ? CircularProgressIndicator(color: CinimexColors.mainOrange)
              : Consumer<ConditionerListModel>(
                  builder: (context, model, child) => Center(
                      child: ConditionerCards(
                          conditioners: model.conditioners,
                          callback: () => {})),
                )),
    );
  }
}
