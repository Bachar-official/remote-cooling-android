import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/cinimex-colors.dart';
import 'package:remote_cooling_android/domain/model/conditioner-list-model.dart';
import 'package:remote_cooling_android/domain/model/settings-model.dart';
import 'package:remote_cooling_android/ui/bottom-bar.dart';
import 'package:remote_cooling_android/ui/empty-name-dialog.dart';

import 'components/conditioner-cards.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerListModel>(context, listen: true);
    var settingsProvider = Provider.of<SettingsModel>(context, listen: true);
    String userName = settingsProvider.userName;

    if (userName == 'Anonymous') {
      return EmptyNameDialog();
    }
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      appBar: AppBar(
        title: Text(
          'Cinimex Cooling',
          style: TextStyle(fontFamily: 'Europe'),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                provider.getConditioners();
              }),
        ],
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
