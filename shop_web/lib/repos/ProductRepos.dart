import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/models/LogModel.dart';
import 'package:login/models/Products.dart';

class ProductRepository {
  Future<String> sendProduct(
      String title, double price, Dio dio, XFile imageFile) async {
    var url =
        'http://localhost:5071/api/Product/insert?title=${title}&price=${price}'; // Замените на свой URL

    try {
      var fileBytes = await imageFile.readAsBytes();
      var formData = FormData.fromMap({
        'photo': MultipartFile.fromBytes(fileBytes, filename: 'photo.png'),
      });
      var response = await dio.post(
        url,
        data: formData,
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

  Future<List<ProductsModel>> getProducts() async {
    try {
      final response =
          await Dio().get("http://localhost:5071/api/Product/select");
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final continents =
            data.map((item) => ProductsModel.fromJson(item)).toList();
        return continents;
      } else {
        throw Exception('Failed to load Products');
      }
    } catch (e) {
      throw Exception('Failed to load Products: $e');
    }
  }
}
