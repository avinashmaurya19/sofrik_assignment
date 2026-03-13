import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofrik_assignment/widget/app_text_style.dart';

import '../components/error_view.dart';
import '../components/loading_view.dart';
import '../components/product_card.dart';
import '../model/product_model.dart';
import '../providers/product_provider.dart';
import '../services/product_service.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProductListModel> _filterByTitle(
    List<ProductListModel> products,
    String query,
  ) {
    if (query.trim().isEmpty) return products;
    final lower = query.trim().toLowerCase();
    return products
        .where((p) => (p.title ?? '').toLowerCase().contains(lower))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final asyncProducts = ref.watch(productsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by product name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
        ),
      ),
      body: asyncProducts.when(
        data: (products) {
          final filtered = _filterByTitle(products, _searchQuery);
          return _ProductGrid(products: filtered, searchQuery: _searchQuery);
        },
        loading: () => const LoadingView(),
        error: (err, _) => ErrorView(
          message: err is ProductFetchException
              ? err.message
              : 'Something went wrong. Please try again.',
          onRetry: () => ref.invalidate(productsFutureProvider),
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<ProductListModel> products;
  final String searchQuery;

  const _ProductGrid({
    required this.products,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          searchQuery.trim().isEmpty
              ? 'No products available.'
              : 'No products found for "$searchQuery"',
          textAlign: TextAlign.center,
          style: AppTextStyles.regularStyle(fontSize: 14),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 265,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          ),
        );
      },
    );
  }
}
