import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:remote_cooling_android/domain/repository/net_repository.dart';
import 'package:remote_cooling_android/entities/conditioner_status.dart';

void main() {
  test('', () async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    DateTime now = DateTime.now();
    NetRepository netRepository = NetRepository(userName: 'testUser');

    String path =
        '192.168.0.100/set';
    Map<String, String> queryParameters = {
      'date': now.toString(),
      'profile': '100',
      'user': 'testUser'
    };
    dioAdapter.onGet(
      path,
      (request) => request.reply(200, {"status": "100", "user": "testUser"}),
      queryParameters: queryParameters,
    );

    final response = await netRepository.sendCommand(
        '192.168.0.100', ConditionerCommand.set_100, now, dio);
    expect(response.data['user'], 'testUser');
    expect(response.data['status'], '100');
  });
}
