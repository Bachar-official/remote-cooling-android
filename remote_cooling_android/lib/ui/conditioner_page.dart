import 'package:flutter/material.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/utils/renderUtils.dart';
import 'package:remote_cooling_android/utils/time_ago.dart';

class ConditionerPage extends StatefulWidget {
  @override
  _ConditionerState createState() => _ConditionerState();
}

class _ConditionerState extends State<ConditionerPage> {
  @override
  Widget build(BuildContext context) {
    Conditioner conditioner = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(conditioner.name),
          actions: [
            IconButton(
              icon: Icon(Icons.qr_code),
              onPressed: () => {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: RenderUtils.generateImage(conditioner.toJson())
                  ),
                ),
              }
            )
          ],
        ),
        body: Builder(
          builder: (ctx) => Column(
              children: [
                RenderUtils.getStatus(conditioner),
                RenderUtils.getUpdated(conditioner),
              ],
            ),
          ),
        );
  }
}
