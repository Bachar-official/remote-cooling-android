import 'dart:convert';

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    Conditioner conditioner = ModalRoute.of(context).settings.arguments;
    bool on = RenderUtils.isConditionerOn(conditioner);
    return Scaffold(
        appBar: AppBar(
          title: Text(conditioner.name),
          actions: [
            Switch(
              value: on,
              onChanged: (value) => {
                InetUtils.sendCommand(
                  conditioner.endpoint,
                  on ? ConditionerCommand.off :
                  ConditionerCommand.on
                ).then((response) => {
                  if (response.statusCode == 200) {
                    setState(() => {
                      conditioner.setStatus(json.decode(response.body)['status'])
                    }),
                    RouteUtils.showNotification(
                      context,
                      'Статус кондиционера "${conditioner.name}" изменен на "${RenderUtils.getStringStatus(conditioner.status)}"',
                      Colors.green)
                  }
                }),
              }),
          ],
        ),
        body: Builder(
          builder: (ctx) => Column(
              children: [
                RenderUtils.getStatus(conditioner),
                RenderUtils.getEndpoint(conditioner),
                RenderUtils.getUpdated(conditioner),
              ],
            ),
          ),
        );
  }
}
