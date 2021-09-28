import 'package:flutter/material.dart';
import 'package:remote_cooling_android/app/routing.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/ui/navbar.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

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
                    child: _ConditionerCards(
                      conditioners: data.data,
                      callback: _update,
                    ));
              case ConnectionState.none:
                return Center(child: Text('Something went wrong!'));
              default:
                return Center(child: Text('Something went wrong!'));
            }
          }),
    );
  }
}

class _ConditionerCards extends StatelessWidget {
  final List<Conditioner> conditioners;
  final Function callback;
  _ConditionerCards({this.conditioners, @required this.callback});

  @override
  Widget build(BuildContext context) {
    if (conditioners == null || conditioners.length == 0) {
      return SizedBox(
        child: Center(
            child: Text('Устройств в вашей подсети не найдено.\n' +
                'Попробуйте повторить поиск или проверьте настройки сети.')));
    }
    return ListView.builder(
      itemCount: conditioners.length,
      itemBuilder: (context, index) {
        return _ConditionerCard(conditioners[index], callback);
      },
    );
  }
}

class _ConditionerCard extends StatelessWidget {
  final Conditioner conditioner;
  final Function callback;
  _ConditionerCard(this.conditioner, this.callback);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: GestureDetector(
          onTap: () => RouteUtils.goToPage(
              context, AppRouter.conditionerPage, conditioner, callback),
          child: Card(
            color: Constants.mainOrange,
            child: Row(
              children: [
                conditioner.name == null
                    ? Text('')
                    : Text(
                        conditioner.name,
                        style:
                            TextStyle(fontSize: 20, color: Constants.mainBlack),
                      ),
                Spacer(),
                getIconStatus(conditioner.status),
              ],
            ),
          )),
    );
  }
}

Icon getIconStatus(ConditionerStatus status) {
  switch (status) {
    case ConditionerStatus.undefined:
      return Icon(Icons.leak_remove, color: Constants.mainBlack);
    case ConditionerStatus.off:
      return Icon(Icons.flash_off, color: Constants.mainBlack);
    case ConditionerStatus.auto:
      return Icon(Icons.auto_fix_high, color: Constants.mainBlack);
    case ConditionerStatus.fan:
      return Icon(Icons.waves, color: Constants.mainBlack);
    case ConditionerStatus.cold17:
      return Icon(Icons.ac_unit, color: Constants.mainBlack);
    case ConditionerStatus.cold22:
      return Icon(Icons.ac_unit_outlined, color: Constants.mainBlack);
    default:
      return Icon(Icons.no_accounts);
  }
}
