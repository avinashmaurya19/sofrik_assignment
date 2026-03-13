import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import '../providers/navigation_provider.dart';
import 'cart_screen.dart';
import 'product_list_screen.dart';

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  static const _screens = [
    ProductListScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartItemCountProvider);
    final currentIndex = ref.watch(selectedTabIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) =>
            ref.read(selectedTabIndexProvider.notifier).state = index,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Products',
          ),
          NavigationDestination(
            icon: _CartBadge(count: cartCount, child: const Icon(Icons.shopping_cart_outlined)),
            selectedIcon: _CartBadge(count: cartCount, child: const Icon(Icons.shopping_cart)),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  final int count;
  final Widget child;

  const _CartBadge({required this.count, required this.child});

  @override
  Widget build(BuildContext context) {
    if (count == 0) return child;

    return Badge(
      label: Text(count > 99 ? '99+' : '$count'),
      child: child,
    );
  }
}
