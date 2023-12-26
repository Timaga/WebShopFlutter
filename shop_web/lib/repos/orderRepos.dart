import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/models/LogModel.dart';
import 'package:login/models/Products.dart';
import 'package:login/models/orderModel.dart';

class OrderRepository {
  Future<String> sendOrder(
      Dio dio, int customer_id, int product_id) async {
    var url =
        'http://localhost:5071/api/Order/add?customer_id=${customer_id}&product_id=${product_id}'; // Замените на свой URL

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

  Future<List<OrderModel>> getOrders(int id_customer) async {
    try {
      final response = await Dio().get(
          'http://localhost:5071/api/Order/select?id_customer=${id_customer}');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final continents =
            data.map((item) => OrderModel.fromJson(item)).toList();
        return continents;
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<String> DeleteOrder(int id) async {
    var dio = Dio(); // Создайте экземпляр Dio

    var url =
        'http://localhost:5071/api/Order/delete?id=${id}'; // Замените на свой URL

    try {
      var response = await dio.delete(
        url,
      );

      if (response.statusCode == 200) {
        print('JSON отправлен успешно');
        final data = response.data;
        return data.toString();
      } else {
        throw Exception('Failed to load Link');
      }
    } catch (e) {
      throw Exception('Failed to load  Link: $e');
    }
  }
}
