import 'package:flutter/material.dart';
import 'package:sofrik_assignment/widget/shimmer_widget.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 265,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const _SkeletonCard(),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 3,
            child: ShimmerContainer(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(width: 60, height: 12, borderRadius: 4),
                const SizedBox(height: 8),
                ShimmerContainer(width: double.infinity, height: 14, borderRadius: 4),
                const SizedBox(height: 4),
                ShimmerContainer(width: 100, height: 14, borderRadius: 4),
                const SizedBox(height: 8),
                ShimmerContainer(width: 50, height: 16, borderRadius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
