import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/view_model/navigation_view_model.dart';
import 'package:remote_cooling_android/domain/view_model/settings_view_model.dart';
import 'package:remote_cooling_android/ui/homepage/components/bottom-bar.dart';
import 'package:remote_cooling_android/ui/empty-name-dialog.dart';
import 'package:remote_cooling_android/ui/settings_page.dart';

import '../about-page.dart';
import '../conditioner_list_page/conditioner_list_page.dart';

class Homepage extends StatelessWidget {
  final int settingsPageNumber = 1;
  @override
  Widget build(BuildContext context) {
    String userName =
        Provider.of<SettingsViewModel>(context, listen: true).userName;
    var navigationProvider =
        Provider.of<NavigationViewModel>(context, listen: true);

    Widget _chooseWidget(int number) {
      switch (number) {
        case 0:
          return ConditionerListPage();
        case 1:
          return SettingsPage();
        case 2:
          return AboutPage();
        default:
          return Center();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinimex Cooling', style: TextStyle(fontFamily: 'Europe')),
      ),
      body: navigationProvider.pageNumber == settingsPageNumber
          ? SettingsPage()
          : userName == 'Anonymous'
              ? EmptyNameDialog(
                  openSettings: navigationProvider.setPage,
                )
              : _chooseWidget(navigationProvider.pageNumber),
      bottomNavigationBar: BottomBar(
        onPageChanged: (pageNumber) => navigationProvider.setPage(pageNumber),
        pageNumber: navigationProvider.pageNumber,
      ),
    );
  }
}
