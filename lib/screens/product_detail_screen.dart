import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofrik_assignment/widget/app_colors.dart';
import 'package:sofrik_assignment/widget/app_text_style.dart';
import 'package:sofrik_assignment/widget/shimmer_widget.dart';

import '../model/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/navigation_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final ProductListModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final isInCart =
        product.id != null &&
        cartItems.any((item) => item.product.id == product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title ?? 'Product',
          style: AppTextStyles.boldStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: product.image ?? '',
                fit: BoxFit.contain,
                placeholder: (context, url) => ShimmerContainer(
                  width: double.infinity,
                  height: double.infinity,
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.broken_image_outlined, size: 64),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.category != null && product.category!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        product.category!,
                        style: AppTextStyles.semiBoldStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  Text(
                    product.title ?? 'Product',
                    style: AppTextStyles.boldStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: AppTextStyles.boldStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 16),
                      if (product.rating != null) ...[
                        Icon(Icons.star, size: 20, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating!.rate} (${product.rating!.count} reviews)',
                          style: AppTextStyles.regularStyle(fontSize: 14),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description',
                    style: AppTextStyles.semiBoldStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? 'No description available.',
                    style: AppTextStyles.regularStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FilledButton.icon(
            onPressed: () {
              if (isInCart) {
                ref.read(selectedTabIndexProvider.notifier).state = 1;
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              } else {
                ref.read(cartProvider.notifier).add(product);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to cart'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            icon: Icon(
              isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
            ),
            label: Text(isInCart ? 'Go to Cart' : 'Add to Cart'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
    );
  }
}
