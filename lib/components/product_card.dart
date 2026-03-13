import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sofrik_assignment/widget/app_colors.dart';
import 'package:sofrik_assignment/widget/app_text_style.dart';
import 'package:sofrik_assignment/widget/shimmer_widget.dart';

import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductListModel product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: product.image ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => ShimmerContainer(
                  width: double.infinity,
                  height: double.infinity,
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.broken_image_outlined, size: 48),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category ?? '',
                    style: AppTextStyles.semiBoldStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.title ?? 'Product',
                    style: AppTextStyles.mediumStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: AppTextStyles.boldStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
