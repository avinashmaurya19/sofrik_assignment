import 'product_model.dart';

/// Represents a product in the shopping cart with quantity.
class CartItemModel {
  final ProductListModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  double get lineTotal =>
      (product.price ?? 0.0) * quantity;

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }
}
