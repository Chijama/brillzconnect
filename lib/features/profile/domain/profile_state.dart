import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Define the provider for SliverScrollNotifier
final sliverScrollProvider = StateNotifierProvider<SliverScrollNotifier, SliverScrollState>(
  (ref) => SliverScrollNotifier(),
);
// Define the scroll state
class SliverScrollState {
  final bool isCollapsed;

  SliverScrollState({required this.isCollapsed});
}

class SliverScrollNotifier extends StateNotifier<SliverScrollState> {
  SliverScrollNotifier()
      : super(SliverScrollState(isCollapsed: false));

  final ScrollController scrollController = ScrollController();
  final double expandedBarHeight = 450.0;
  final double collapsedBarHeight = 80.0;

  // Initialize listener for scroll events
  void initialize() {
    scrollController.addListener(_onScroll);
  }

  // Scroll listener to detect if AppBar is collapsed
  void _onScroll() {
    final isCollapsed = scrollController.hasClients &&
        scrollController.offset > (expandedBarHeight - collapsedBarHeight);
    
    // Update the state
    state = SliverScrollState(isCollapsed: isCollapsed);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
