import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier to manage the selected interests
class InterestsNotifier extends StateNotifier<List<String>> {
  InterestsNotifier() : super([]);

  // Toggle an interest: add if not selected, remove if already selected
  void toggleInterest(String interest) {
    if (state.contains(interest)) {
      state = List.from(state)..remove(interest);
    } else {
      state = List.from(state)..add(interest);
    }
  }
}

// Provide the notifier
final interestsProvider = StateNotifierProvider<InterestsNotifier, List<String>>((ref) {
  return InterestsNotifier();
});
