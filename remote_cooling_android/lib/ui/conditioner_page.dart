import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';
import 'package:remote_cooling_android/utils/time_ago.dart';

class ConditionerPage extends StatefulWidget {
  @override
  _ConditionerState createState() => _ConditionerState();
}

class _ConditionerState extends State<ConditionerPage> {
  bool isLoading = false;
  bool on;

  @override
  Widget build(BuildContext context) {
    Conditioner conditioner = ModalRoute.of(context).settings.arguments;

    void _setMode(ConditionerStatus status) async {
      ConditionerCommand command = InetUtils.statusToCommand(status);
      setState(() {
        isLoading = true;
      });
      try {
        var response =
            await InetUtils.sendCommand(conditioner.endpoint, command);
        if (response.statusCode == 200) {
          setState(() {
            conditioner.setStatus(json.decode(response.body)['status']);
            conditioner.setUsername(json.decode(response.body)['user']);
            isLoading = false;
          });
        }
      } on SocketException catch (exception) {
        setState(() {
          isLoading = false;
          RouteUtils.showNotification(context, exception.message, Colors.red);
        });
      }
    }

    on = _isConditionerOn(conditioner);
    return Scaffold(
      appBar: AppBar(
        title: Text(conditioner.name),
        actions: [
          isLoading
              ? Icon(Icons.watch_later_outlined, color: Constants.mainOrange)
              : Switch(
                  value: on,
                  onChanged: (value) {
                    setState(() {
                      isLoading = true;
                    });
                    InetUtils.sendCommand(
                            conditioner.endpoint,
                            on
                                ? ConditionerCommand.off
                                : ConditionerCommand.set_100)
                        .then((response) => {
                              if (response == null)
                                {
                                  RouteUtils.showNotification(
                                      context,
                                      'Проверьте подключение к сети!',
                                      Colors.red)
                                }
                              else if (response.statusCode == 200)
                                {
                                  setState(() {
                                    conditioner.setStatus(
                                        json.decode(response.body)['status']);
                                    isLoading = false;
                                  }),
                                  RouteUtils.showNotification(
                                      context,
                                      'Статус кондиционера "${conditioner.name}" изменен!"',
                                      Colors.green),
                                }
                            });
                  }),
        ],
      ),
      body: Builder(
        builder: (ctx) => _ConditionerBody(
          isLoading: isLoading,
          conditioner: conditioner,
          setMode: _setMode,
        )
      ),
    );
  }
}

class _ConditionerBody extends StatelessWidget {
  final bool isLoading;
  final Conditioner conditioner;
  final Function setMode;
  _ConditionerBody({this.isLoading, this.conditioner, this.setMode});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: isLoading
            ? [
                Center(
                    child:
                        CircularProgressIndicator(color: Constants.mainOrange))
              ]
            : [
              _getStatus(conditioner),
                  Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  _renderModeChoose(conditioner, setMode),
                  Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Spacer(),
                  _ConditionerFooter(conditioner: conditioner)
            ]);
  }
}

class _ConditionerFooter extends StatelessWidget {
  final Conditioner conditioner;
  _ConditionerFooter({this.conditioner});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_getEndpoint(conditioner), _getUpdated(conditioner)],
    );
  }
}

Row _getUpdated(Conditioner conditioner) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text('Обновлено: '),
    Text(TimeAgo.timeAgoSinceDate(conditioner.updatedAt)),
    Text(' пользователем ${conditioner.userName}')
  ]);
}

String _getStringStatus(ConditionerStatus status) {
  switch (status) {
    case ConditionerStatus.off:
      return 'выключен';
    case ConditionerStatus.undefined:
      return 'нет связи';
    case ConditionerStatus.cold17:
      return 'охлаждение, 17°С';
    case ConditionerStatus.cold22:
      return 'охлаждение, 22°С';
    case ConditionerStatus.fan:
      return 'проветривание';
    case ConditionerStatus.auto:
      return 'авто';
    default:
      return 'нет связи';
  }
}

Row _getEndpoint(Conditioner conditioner) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('API: '),
      Text(conditioner.endpoint),
    ],
  );
}

String _getTemperature(ConditionerStatus status) {
  switch (status) {
    case ConditionerStatus.auto:
      return '--';
    case ConditionerStatus.cold17:
      return '17°С';
    case ConditionerStatus.cold22:
      return '22°С';
    case ConditionerStatus.fan:
      return '--';
    case ConditionerStatus.off:
      return '--';
    case ConditionerStatus.undefined:
    default:
      return '--';
  }
}

String _getMode(ConditionerStatus status) {
  switch (status) {
    case ConditionerStatus.auto:
      return 'автоматически';
    case ConditionerStatus.cold17:
    case ConditionerStatus.cold22:
      return 'охлаждение';
    case ConditionerStatus.fan:
      return 'проветривание';
    case ConditionerStatus.off:
      return 'выключен';
    case ConditionerStatus.undefined:
    default:
      return '-';
  }
}

Column _getStatus(Conditioner conditioner) {
  return Column(
    children: [
      Text(
        _getTemperature(conditioner.status),
        style: TextStyle(fontSize: 100),
      ),
      Text(
        _getMode(conditioner.status),
        style: TextStyle(fontSize: 60),
      ),
    ],
  );
}

bool _isConditionerOn(Conditioner conditioner) {
  switch (conditioner.status) {
    case ConditionerStatus.off:
      return false;
    case ConditionerStatus.auto:
    case ConditionerStatus.cold17:
    case ConditionerStatus.cold22:
    case ConditionerStatus.fan:
      return true;
    default:
      return false;
  }
}

Column _renderModeChoose(Conditioner conditioner, Function onChange) {
  return Column(
    children: [
      ListTile(
        title: Text(_getStringStatus(ConditionerStatus.auto)),
        leading: Radio(
            value: ConditionerStatus.auto,
            groupValue: conditioner.status,
            onChanged: (value) {
              onChange(value);
            }),
      ),
      ListTile(
        title: Text(_getStringStatus(ConditionerStatus.cold17)),
        leading: Radio(
            value: ConditionerStatus.cold17,
            groupValue: conditioner.status,
            onChanged: (value) {
              onChange(value);
            }),
      ),
      ListTile(
        title: Text(_getStringStatus(ConditionerStatus.cold22)),
        leading: Radio(
            value: ConditionerStatus.cold22,
            groupValue: conditioner.status,
            onChanged: (value) {
              onChange(value);
            }),
      ),
      ListTile(
        title: Text(_getStringStatus(ConditionerStatus.fan)),
        leading: Radio(
            value: ConditionerStatus.fan,
            groupValue: conditioner.status,
            onChanged: (value) {
              onChange(value);
            }),
      ),
    ],
  );
}
