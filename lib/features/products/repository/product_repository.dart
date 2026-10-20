import '../../../core/network/api_service.dart';
import '../../../models/product_model.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  Future<List<ProductModel>> fetchProducts() async {
    return await _apiService.fetchProducts();
  }
}
