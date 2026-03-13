import 'package:flutter/material.dart';
import 'package:sofrik_assignment/widget/app_colors.dart';
import 'package:sofrik_assignment/widget/app_text_style.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Your cart is empty',
              style: AppTextStyles.boldStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Add items from the product list to get started.',
              textAlign: TextAlign.center,
              style: AppTextStyles.regularStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
