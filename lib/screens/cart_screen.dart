import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofrik_assignment/widget/app_colors.dart';
import 'package:sofrik_assignment/widget/app_text_style.dart';

import '../components/empty_cart_view.dart';
import '../model/cart_item_model.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = cartItems.fold(0.0, (s, e) => s + e.lineTotal);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cartItems.isEmpty
          ? const EmptyCartView()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) =>
                        _CartItemTile(item: cartItems[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                  ),
                ),
                _CartSummary(
                  total: total,
                  onCheckout: () => _handleCheckout(context, ref),
                ),
              ],
            ),
    );
  }

  void _handleCheckout(BuildContext context, WidgetRef ref) {
    ref.read(cartProvider.notifier).clear();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you! Your order has been placed.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _CartItemTile extends ConsumerWidget {
  final CartItemModel item;

  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = item.product;
    final productId = product.id;
    if (productId == null) return const SizedBox.shrink();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.title ?? 'Product',
                    style: AppTextStyles.mediumStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 20,
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () =>
                      ref.read(cartProvider.notifier).remove(productId),
                ),
              ],
            ),
            // const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Unit: \$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                  style: AppTextStyles.regularStyle(fontSize: 12),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.1),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: item.quantity == 1
                            ? null
                            : () {
                                final q = item.quantity - 1;
                                ref
                                    .read(cartProvider.notifier)
                                    .setQuantity(productId, q);
                              },
                        child: const Icon(Icons.remove, size: 20),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${item.quantity}',
                          style: AppTextStyles.mediumStyle(fontSize: 16),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ref
                              .read(cartProvider.notifier)
                              .setQuantity(productId, item.quantity + 1);
                        },
                        child: const Icon(Icons.add, size: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Line total: \$${item.lineTotal.toStringAsFixed(2)}',
              style: AppTextStyles.boldStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final double total;
  final VoidCallback onCheckout;

  const _CartSummary({required this.total, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
      decoration: const BoxDecoration(color: AppColors.white),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: AppTextStyles.mediumStyle(fontSize: 18)),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: AppTextStyles.boldStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onCheckout,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
