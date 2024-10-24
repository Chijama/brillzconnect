import 'package:brillzconnect/common/color.dart';
import 'package:brillzconnect/common/text_field.dart';
import 'package:brillzconnect/common/text_style.dart';
import 'package:brillzconnect/features/authentication/domain/register_state.dart';
import 'package:brillzconnect/features/authentication/domain/user_state.dart';
import 'package:brillzconnect/features/authentication/models/user_model.dart';
import 'package:brillzconnect/features/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>(); // Form key for validation

    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();

    final List<String> interests = [
      'Football',
      'Basketball',
      'Ice Hockey',
      'Motorsports',
      'Bandy',
      'Rugby',
      'Skiing',
      'Shooting',
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style:
                      getBlackZodiak(fontsize: 29, fontweight: FontWeight.w600),
                ),
                const SizedBox(height: 15),

                // Username Input
                CustomBoxTextField(
                  controller: usernameController,
                  label: 'Username',
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
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),

                // Phone Input
                CustomBoxTextField(
                  controller: phoneController,
                  label: 'Phone',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),

                // Password Input
                CustomPasswordField(
                  controller: passwordController,
                  label: 'Password',
                ),
                const SizedBox(height: 20),

                // Interest Section Title
                Text(
                  "Select Interests",
                  style: getPlusJakartaSans(
                    textColor: AppColors.appBlack,
                    fontsize: 14,
                    fontweight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 9),

                // Interest Selection using ChoiceChips
                Consumer(builder: (context, ref, _) {
                  final selectedInterests = ref.watch(interestsProvider);
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: interests.map((interest) {
                      final isSelected = selectedInterests.contains(interest);
                      return ChoiceChip(
                        label: Text(interest),
                        selected: isSelected,
                        selectedColor: const Color.fromARGB(255, 186, 114, 199),
                        onSelected: (bool selected) {
                          // Toggle the interest using the provider
                          ref
                              .read(interestsProvider.notifier)
                              .toggleInterest(interest);
                        },
                      );
                    }).toList(),
                  );
                }),
                const SizedBox(height: 20),

                // Register Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final selectedInterests = ref.read(interestsProvider);

                        // Update user state in Riverpod
                        ref.read(userProvider.notifier).state = User(
                          username: usernameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          interests:
                              selectedInterests, // Pass the selected interests list
                          password: passwordController.text,
                        );

                        // Navigate to HomeScreen after successful registration
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavBar()),
                        );
                      }
                    },
                    child: const Text('Register'),
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
