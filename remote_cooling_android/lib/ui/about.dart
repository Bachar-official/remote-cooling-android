import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatelessWidget{

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О программе'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Text('Cinimex Cooling'),
              FutureBuilder<String>(
                  future: getVersion(),
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    final text = data != null ? data : '';
                    return Text('Version ${text}');
                  }),
              Text('Developer: Ivan Bacharnikov'),
              Text('Email: ibacharnikov@cinimex.ru'),
              Text('Github: https://github.com/Bachar_official'),
              Text('Telegram: @Bachar-official')
            ],
          ),
        ),
      ),
    );
  }
}