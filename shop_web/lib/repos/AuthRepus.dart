import 'package:dio/dio.dart';
import 'package:login/models/LogModel.dart';

class AuthRepository {
  Future<String> sendLog(String password, String login, Dio dio) async {
    var url =
        'http://localhost:5071/api/Auth/insert?login=${login}&password=${password}'; // Замените на свой URL

    try {
      var response = await dio.post(
        url,
      );

      print('JSON отправлен успешно');
      final data = response.data;
      return data.toString();
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  }
}
