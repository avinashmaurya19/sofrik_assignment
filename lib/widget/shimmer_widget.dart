import 'package:flutter/material.dart';

class ShimmerWidget extends StatefulWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ?? Colors.grey[300];
    final highlightColor = widget.highlightColor ?? Colors.grey[100];

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 + _animation.value * 2, 0.0),
              end: Alignment(1.0 + _animation.value * 2, 0.0),
              colors: [
                baseColor ?? Colors.grey[300]!,
                baseColor ?? Colors.grey[300]!,
                highlightColor ?? Colors.grey[100]!,
                baseColor ?? Colors.grey[300]!,
                baseColor ?? Colors.grey[300]!,
              ],
              stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}

/// Shimmer container widget - a simple rectangular shimmer placeholder
class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 0,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Interest card shimmer - matches the interest card layout
class InterestCardShimmer extends StatelessWidget {
  const InterestCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShimmerContainer(width: 96, height: 96, borderRadius: 26),
        SizedBox(height: 6),
        ShimmerContainer(width: 60, height: 14, borderRadius: 4),
      ],
    );
  }
}
