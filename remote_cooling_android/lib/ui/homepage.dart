import 'package:flutter/material.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/ui/navbar.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';
import 'package:remote_cooling_android/utils/renderUtils.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<List<Conditioner>> conditioners;

  @override
  void initState() {
    super.initState();
    try {
      conditioners = InetUtils.sendBroadcast();
    } catch (e) {
      print(e);
    }
  }

  void _update() {
    setState(() {
      try {
        conditioners = InetUtils.sendBroadcast();
      } catch (e) {
        print(e);
      }
    });
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
              onPressed: () {
                _update();
              }),
        ],
      ),
      body: FutureBuilder(
          future: conditioners,
          builder: (ctx, data) {
            switch (data.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child:
                        CircularProgressIndicator(color: Constants.mainOrange));
              case ConnectionState.done:
                return Center(
                    child: Column(
                        children: RenderUtils.renderCards(
                  data.data,
                  context,
                  _update,
                )));
              case ConnectionState.none:
                return Center(child: Text('Something went wrong!'));
              default:
                return Center(child: Text('Something went wrong!'));
            }
          }),
    );
  }
}
