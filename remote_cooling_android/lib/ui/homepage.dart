import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/ui/navbar.dart';
import 'package:remote_cooling_android/utils/renderUtils.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Conditioner> conditioners = [
    Conditioner('Кухня', '/kitchen', ConditionerStatus.off, DateTime.now()),
    Conditioner('Север', '/north', ConditionerStatus.undefined,
        DateTime(2021, 8, 1, 14, 30))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Cinimex Охлаждайка'),
        actions: [
          IconButton(
              onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                            title: Text('Выберите вариант'),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  TextButton(
                                      onPressed: () => {
                                        RouteUtils.goToPage(context, AppRouter.newConditioner, null)
                                      },
                                      child: Text('Добавить вручную')),
                                  TextButton(
                                      onPressed: () => {
                                            BarcodeScanner.scan()
                                                .then(
                                                    (value) =>
                                                        setState(
                                                            () => {
                                                                  conditioners.add(
                                                                      Conditioner
                                                                          .fromJson(
                                                                              jsonDecode(value.rawContent)))
                                                                }))
                                          },
                                      child: Text('Сканировать QR-код')),
                                ],
                              ),
                            ))),
                  },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Builder(
        builder: (ctx) => Column(
          children: RenderUtils.renderConditioners(conditioners, ctx),
        ),
      ),
    );
  }
}
