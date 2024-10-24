import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider =
    StateNotifierProvider<VisibilityNotifier, bool>(
        (ref) => VisibilityNotifier());
final reEnterPasswordVisibilityProvider =
    StateNotifierProvider<VisibilityNotifier, bool>(
        (ref) => VisibilityNotifier());

class VisibilityNotifier extends StateNotifier<bool> {
  VisibilityNotifier() : super(true);

  void toggleVisibility() {
    state = !state;
  }
}
