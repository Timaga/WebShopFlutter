import 'package:dio/dio.dart';

class LogRepository {Future<String> sendLog(String message, String ip,Dio dio) async {

    var url =
        'http://localhost:5071/api/LogsContoller/insert?message=${message}&ip=${ip}'; // Замените на свой URL

    try {
      var response = await dio.post(
        url,
      );

      if (response.statusCode == 200) {
        print('JSON отправлен успешно');
        final data = response.data;
        return data.toString();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      throw Exception('Failed to load: $e');
    }
  }
}
