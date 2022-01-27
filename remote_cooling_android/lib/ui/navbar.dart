import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/domain/model/settings-model.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userName =
        Provider.of<SettingsModel>(context, listen: false).userName;
    return Container(
        width: 220,
        child: Drawer(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  backgroundColor: Constants.mainBlue,
                  foregroundColor: Colors.white,
                  radius: 30,
                  child: Icon(Icons.account_circle, size: 50),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    userName,
                    style: TextStyle(fontSize: 20, fontFamily: 'Europe'),
                  ))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ElevatedButton.icon(
                    onPressed: () {
                      RouteUtils.goToPage(
                          context, AppRouter.settingsPage, null, () => {});
                    },
                    icon: Icon(Icons.settings),
                    label: Text('Настройки')),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ElevatedButton.icon(
                    onPressed: () {
                      RouteUtils.goToPage(
                          context, AppRouter.aboutPage, null, () => {});
                    },
                    icon: Icon(Icons.add_to_home_screen),
                    label: Text('О программе')),
              ),
            ],
          ),
        ));
  }
}
