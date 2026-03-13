import 'package:dio/dio.dart';

import '../data/constant.dart';
import '../model/product_model.dart';

/// Thrown when product fetch fails.
class ProductFetchException implements Exception {
  final String message;
  final Object? cause;

  ProductFetchException(this.message, [this.cause]);

  @override
  String toString() => 'ProductFetchException: $message';
}

/// Service for fetching products from the Fake Store API.
class ProductService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  /// Fetches all products. Throws [ProductFetchException] on failure.
  Future<List<ProductListModel>> fetchProducts() async {
    try {
      final response = await _dio.get(Constants.getAllProducts);

      if (response.statusCode != 200) {
        throw ProductFetchException(
          'Failed to load products (${response.statusCode})',
        );
      }

      final list = response.data;
      if (list == null) {
        throw ProductFetchException('No data returned from API');
      }

      // response.data is dynamic, so we cast to List before using .map()
      final listOfMaps = list as List;
      return listOfMaps
          .map((e) => ProductListModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final message = switch (e.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          'Request timed out. Please check your connection.',
        DioExceptionType.connectionError =>
          'No internet connection. Please try again.',
        _ => e.response?.statusMessage ?? e.message ?? 'Something went wrong.',
      };
      throw ProductFetchException(message, e);
    } catch (e) {
      if (e is ProductFetchException) rethrow;
      throw ProductFetchException(
        'Failed to load products. Please try again.',
        e,
      );
    }
  }

  /// Fetches a single product by id.
  Future<ProductListModel?> fetchProductById(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${Constants.getAllProducts}/$id',
      );

      if (response.statusCode != 200 || response.data == null) {
        return null;
      }

      return ProductListModel.fromJson(response.data!);
    } on DioException catch (_) {
      return null;
    }
  }
}
