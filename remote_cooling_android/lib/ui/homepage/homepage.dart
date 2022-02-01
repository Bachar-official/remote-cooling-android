import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/model/navigation-model.dart';
import 'package:remote_cooling_android/domain/model/settings-model.dart';
import 'package:remote_cooling_android/ui/homepage/components/bottom-bar.dart';
import 'package:remote_cooling_android/ui/empty-name-dialog.dart';
import 'package:remote_cooling_android/ui/settings-page.dart';

import '../about-page.dart';
import '../conditioner-list-page/conditioner-list-page.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userName = Provider.of<SettingsModel>(context, listen: true).userName;
    var navigationProvider = Provider.of<NavigationModel>(context, listen:true);

    Widget _chooseWidget(int number) {
      switch(number) {
        case 0: return ConditionerListPage();
        case 1: return SettingsPage();
        case 2: return AboutPage();
        default: return Center();
      }
    }

    if(userName == 'Anonymous') {
      return EmptyNameDialog();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Cinimex Cooling', style: TextStyle(fontFamily: 'Europe')),
      ),
      body: _chooseWidget(navigationProvider.pageNumber),
      bottomNavigationBar: BottomBar(
        onPageChanged: (pageNumber) => navigationProvider.setPage(pageNumber),
        pageNumber: navigationProvider.pageNumber,
      ),
    );
  }
}