import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../model/cart_item_model.dart';
import '../model/product_model.dart';

class CartNotifier extends StateNotifier<List<CartItemModel>> {
  CartNotifier() : super([]);

  void add(ProductListModel product, {int quantity = 1}) {
    if (product.id == null) return;

    final newList = <CartItemModel>[];
    var found = false;

    for (final item in state) {
      if (item.product.id == product.id) {
        newList.add(item.copyWith(quantity: item.quantity + quantity));
        found = true;
      } else {
        newList.add(item);
      }
    }
    if (!found) {
      newList.add(CartItemModel(product: product, quantity: quantity));
    }
    state = newList;
  }

  void setQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    final newList = <CartItemModel>[];
    for (final item in state) {
      if (item.product.id == productId) {
        newList.add(item.copyWith(quantity: quantity));
      } else {
        newList.add(item);
      }
    }
    state = newList;
  }

  void remove(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void clear() {
    state = [];
  }

  double get total {
    double sum = 0;
    for (final item in state) {
      sum += item.lineTotal;
    }
    return sum;
  }

  int get itemCount {
    int count = 0;
    for (final item in state) {
      count += item.quantity;
    }
    return count;
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItemModel>>((ref) {
  return CartNotifier();
});

final cartItemCountProvider = Provider<int>((ref) {
  int count = 0;
  for (final item in ref.watch(cartProvider)) {
    count += item.quantity;
  }
  return count;
});
