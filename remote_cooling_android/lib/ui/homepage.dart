import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/ui/navbar.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';
import 'package:remote_cooling_android/utils/renderUtils.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<List<String>> endpoints;

  @override
  void initState() {
    super.initState();
    endpoints = InetUtils.pingHosts();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Cinimex Охлаждайка'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => {
                    
                  }),
        ],
      ),
      body: FutureBuilder(
        future: endpoints,
        builder: (ctx, data) {
          switch(data.connectionState) {
            case ConnectionState.waiting: return Text('loading');
            case ConnectionState.done: return Text(data.data.length.toString());
            default: return null;
          }
        }
      ),
    );
  }
}
