import 'package:dio/dio.dart';
import 'package:login/models/LogModel.dart';

class LogRepository {
  Future<String> sendLog(String message, String ip,Dio dio,String route) async {

    var url =
        'http://localhost:5071/api/LogsContoller/insert?message=${message}&ip=${ip}&route=${route}'; // Замените на свой URL

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

   Future<List<LogModel>> getLogs() async {
    try {
      final response =
          await Dio().get("http://localhost:5071/api/LogsContoller/select");
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final continents =
            data.map((item) => LogModel.fromJson(item)).toList();
        return continents;
      } else {
        throw Exception('Failed to load logs');
      }
    } catch (e) {
      throw Exception('Failed to load logs: $e');
    }
  }

}
