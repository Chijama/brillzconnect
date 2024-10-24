// State provider for the user
import 'package:brillzconnect/features/authentication/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<User?>((ref) => null);

// Provider to check if the user is logged in
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(userProvider)?.email == null;
});