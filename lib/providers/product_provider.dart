import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';
import '../services/product_service.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

final productsFutureProvider = FutureProvider<List<ProductListModel>>((ref) async {
  final service = ref.watch(productServiceProvider);
  return service.fetchProducts();
});
