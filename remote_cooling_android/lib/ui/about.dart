import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'ibacharnikov@cinimex.ru',
  query:
      encodeQueryParameters(<String, String>{'subject': 'Cinimex Cooling app'}),
);

final Uri githubLaunchUri = Uri(
  scheme: 'https',
  path: 'github.com/Bachar-official',
);

final Uri telegramLaunchUri = Uri(
  scheme: 'https',
  path: 'telegram.me/Bachar_official',
);

TextStyle linksStyle = TextStyle(fontSize: 15);

class AboutPage extends StatelessWidget {
  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'О программе',
          style: TextStyle(fontFamily: 'Europe'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cinimex Cooling',
                      style: TextStyle(fontFamily: 'Europe', fontSize: 30),
                    ),
                    FutureBuilder<String>(
                        future: getVersion(),
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          final text = data != null ? data : '';
                          return Text(
                            text,
                            style:
                                TextStyle(fontFamily: 'Europe', fontSize: 10),
                          );
                        }),
                  ]),
              Text('Разработчик: Иван Бачарников'),
              TextButton(
                child: Text(
                  'Написать на электронную почту',
                  style: linksStyle,
                ),
                onPressed: () => launch(emailLaunchUri.toString()),
              ),
              TextButton(
                child: Text(
                  'Посмотреть профиль GitHub',
                  style: linksStyle,
                ),
                onPressed: () => launch(githubLaunchUri.toString()),
              ),
              TextButton(
                child: Text(
                  'Связаться через Telegram',
                  style: linksStyle,
                ),
                onPressed: () => launch(telegramLaunchUri.toString()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
