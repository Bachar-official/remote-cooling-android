import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/domain/view_model/settings_view_model.dart';
import 'package:remote_cooling_android/ui/ui_constants/colors.dart';
import 'package:skeletons/skeletons.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var themeProvider =
        Provider.of<SettingsViewModel>(context, listen: true).theme;
    return SkeletonTheme(
      darkShimmerGradient: LinearGradient(colors: skeletonGradient),
      child: MaterialApp(
        title: 'Cinimex Conditioner',
        theme: themeProvider,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
