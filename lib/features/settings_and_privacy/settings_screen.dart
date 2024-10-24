import 'package:brillzconnect/common/text_field.dart';
import 'package:brillzconnect/features/authentication/domain/user_state.dart';
import 'package:brillzconnect/features/authentication/login_screen.dart';
import 'package:brillzconnect/features/authentication/models/user_model.dart';
import 'package:brillzconnect/features/settings_and_privacy/domiain/password_visibility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPrivacyPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SettingsPrivacyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the password visibility state
    ref.watch(passwordVisibilityProvider);
    ref.watch(reEnterPasswordVisibilityProvider);

    // Get the current user from the provider
    final user = ref.watch(userProvider.notifier).state;
    final currentUser = user ?? User.defaultUser();

    // Controllers for the form fields
    final TextEditingController emailController =
        TextEditingController(text: currentUser.email);
    final TextEditingController usernameController =
        TextEditingController(text: currentUser.username);
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController reEnterPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Privacy'),automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username Input
                CustomBoxTextField(
                  controller: usernameController,
                  label: 'Update Username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Email Input
                CustomBoxTextField(
                  controller: emailController,
                  label: 'Update Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Password Input
                CustomPasswordField(
                  controller: passwordController,
                  label: 'Change Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Re-enter Password Input
                CustomPasswordField(
                  controller: reEnterPasswordController,
                  label: 'Re-enter Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter the password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Save Changes Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save changes to the user provider
                        ref.read(userProvider.notifier).state = User(
                          username: usernameController.text,
                          email: emailController.text,
                          phone: currentUser.phone, // Keep phone as-is
                          interests:
                              currentUser.interests, // Keep interests as-is
                          password: passwordController.text, // New password
                        );

                        // Simulate successful update
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Settings updated successfully'),
                          ),
                        );
                      }
                    },
                    child: const Text('Save Changes'),
                  ),
                ),
                const SizedBox(height: 40),

                // Logout Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Logout button color
                    ),
                    onPressed: () {
                      // Set the userProvider state to null to log the user out
                      ref.read(userProvider.notifier).state = null;
                      // Simulate logout by navigating back to login screen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
