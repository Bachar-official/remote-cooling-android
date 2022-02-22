import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/view_model/conditioner_list_view_model.dart';
import 'package:remote_cooling_android/domain/view_model/settings_view_model.dart';
import 'package:remote_cooling_android/ui/ui_constants/theme.dart';

import 'components/conditioner_cards.dart';

class ConditionerListPage extends StatelessWidget {
  const ConditionerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConditionerListViewModel>(context, listen: true);
    String themeName =
        Provider.of<SettingsViewModel>(context, listen: false).themeName;
    const String cmxName = 'Cinimex';

    Color? backgroundRefreshColor = themeName == cmxName ? cmxBlue : null;
    Color? foregroundRefreshColor = themeName == cmxName ? cmxOrange : null;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: provider.isLoading
            ? Icon(Icons.watch_later_outlined)
            : Icon(Icons.refresh),
        onPressed: () async => provider.getConditioners(),
      ),
      body: RefreshIndicator(
          backgroundColor: backgroundRefreshColor,
          color: foregroundRefreshColor,
          onRefresh: () async => provider.getConditioners(),
          child: ConditionerCards(
              isLoading: provider.isLoading,
              conditioners: provider.conditioners,
              callback: () => {})),
    );
  }
}
