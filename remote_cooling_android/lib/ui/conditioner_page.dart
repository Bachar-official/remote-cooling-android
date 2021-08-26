import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:remote_cooling_android/constants.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';
import 'package:remote_cooling_android/utils/inetUtils.dart';
import 'package:remote_cooling_android/utils/renderUtils.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';

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

    void _setMode(ConditionerStatus status) {
      ConditionerCommand command = InetUtils.statusToCommand(status);
      setState(() {
        isLoading = true;
      });
      InetUtils.sendCommand(conditioner.endpoint, command).then((response) => {
            if (response == null) {
              isLoading = false,
              RouteUtils.showNotification(context, 'Проверьте подключение к сети!', Colors.red)
            }
            else if (response.statusCode == 200)
              {
                setState(() {
                  conditioner.setStatus(json.decode(response.body)['status']);
                  isLoading = false;
                })
              }
          });
    }

    on = RenderUtils.isConditionerOn(conditioner);
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
                                    context, 'Проверьте подключение к сети!', Colors.red)
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
        builder: (ctx) => Column(
          children: isLoading
              ? [
                  Center(
                      child: CircularProgressIndicator(
                          color: Constants.mainOrange))
                ]
              : [
                  RenderUtils.getStatus(conditioner),
                  Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  RenderUtils.renderModeChoose(conditioner, _setMode),
                  Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Spacer(),
                  RenderUtils.getEndpoint(conditioner),
                  RenderUtils.getUpdated(conditioner),
                ],
        ),
      ),
    );
  }
}
