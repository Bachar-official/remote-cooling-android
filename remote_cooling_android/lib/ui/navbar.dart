import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/utils/renderUtils.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        child: Drawer(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ElevatedButton.icon(
                    onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) =>
                                RenderUtils.renderAlert(
                                    'Выберите вариант',
                                    200,
                                    100,
                                    [
                                      TextButton(
                                          onPressed: () => {
                                                RouteUtils.goToPage(
                                                    context,
                                                    AppRouter.newConditioner,
                                                    null)
                                              },
                                          child: Text('Добавить вручную')),
                                      TextButton(
                                          onPressed: () => {
                                                BarcodeScanner.scan()
                                                    .then(
                                                        (value) => 
                                                            RouteUtils.showNotification(ctx, value.rawContent, Colors.yellow)
                                                    )},
                                          child: Text('Сканировать QR-код')),
                                    ],
                                    null),
                          ),
                        },
                    icon: Icon(Icons.add),
                    label: Text('Добавить кондиционер')),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ElevatedButton.icon(
                    onPressed: () => {},
                    icon: Icon(Icons.settings),
                    label: Text('Настройки')),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ElevatedButton.icon(
                    onPressed: () => {
                          RouteUtils.goToPage(
                              context, AppRouter.aboutPage, null),
                        },
                    icon: Icon(Icons.add_to_home_screen),
                    label: Text('О программе')),
              ),
            ],
          ),
        ));
  }
}
