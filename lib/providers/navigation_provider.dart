import 'package:flutter_riverpod/legacy.dart';

/// Index of the selected tab in the main bottom navigation (0 = Products, 1 = Cart).
final selectedTabIndexProvider = StateProvider<int>((ref) => 0);
