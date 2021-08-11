import 'package:flutter/material.dart';
import 'package:remote_cooling_android/utils/routeUtils.dart';
import 'package:remote_cooling_android/utils/validation.dart';

class NewConditionerPage extends StatefulWidget {
  @override
  _NewConditionerState createState() => _NewConditionerState();
}

class _NewConditionerState extends State<NewConditionerPage> {
  String name = '';
  String endpoint = '';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Добавить кондиционер'),
          ),
          body: Builder(
            builder: (ctx) => Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: name,
                    validator: ValidationUtils.validateNull,
                    decoration: InputDecoration(hintText: 'Название'),
                    onChanged: (value) => name = value,
                  ),
                  TextFormField(
                    initialValue: endpoint,
                    validator: ValidationUtils.validateNull,
                    decoration: InputDecoration(hintText: 'API'),
                    onChanged: (value) => endpoint = value,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      if (_formKey.currentState.validate()) {
                        RouteUtils.showNotification(ctx, 'Добавлено!', Colors.green),
                      }
                    },
                    child: Text('Добавить'),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
          return Future.value(false);
        });
  }
}
