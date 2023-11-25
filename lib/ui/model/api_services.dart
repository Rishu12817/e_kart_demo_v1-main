import 'dart:convert';
// import 'package:api_integrate_v1/atestdemon/model.dart';
import 'package:e_kart_demo_v1/ui/model/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<ModelProduct> fetchData(int limit) async {
    var response = await http.get(Uri.parse(
        "https://dummyjson.com/products?limit=$limit&select=title,price,thumbnail"));
    if (response.statusCode == 200) {
      return ModelProduct.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
