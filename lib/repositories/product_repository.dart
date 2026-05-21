import 'dart:convert';
import 'package:demo_project/models/product_model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<ProductModel>> getProduct() async {
    //https://dummyjson.com/products
    try {
      var url = Uri.https('dummyjson.com', 'products');
      // var response = await http.get(url);
      // بنضيف timeout مدته 10 ثوان عشان لو السيرفر علق يفصل بأمان
      var response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> list = data['products'];
        return list.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get products.');
      }
    } catch (e) {
      throw Exception('Failed to get products');
    }
  }
}
