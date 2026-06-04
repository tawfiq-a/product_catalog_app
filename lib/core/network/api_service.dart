import 'dart:convert';

import '../../models/product_model.dart';
import 'api_constants.dart';
import 'dio_client.dart';

class ApiService {
  final DioClient client;

  ApiService({DioClient? client}) : client = client ?? DioClient();

  Future<List<ProductModel>> fetchProducts() async {
    final resp = await client.get(ApiConstants.products);
    if (resp.statusCode == 200) {
      final data = resp.data;
      if (data is List) {
        return data
            .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      if (data is String) {
        final decoded = jsonDecode(data) as List<dynamic>;
        return decoded
            .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }
    return [];
  }
}
