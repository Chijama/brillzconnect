import 'package:brillzconnect/common/text_field.dart';
import 'package:brillzconnect/common/text_style.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  "Enter your email address to reset your password.",
                  textAlign: TextAlign.center,
                  style:
                      getBlackZodiak(fontsize: 24, fontweight: FontWeight.w400),
                ),
                const SizedBox(height: 8),

                // Email input field
                CustomBoxTextField(
                  controller: _emailController,
                  label: '',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Submit button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Simulate sending reset email
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Password reset link sent to ${_emailController.text}')),
                        );
                      }
                    },
                    child: const Text('Send Reset Link'),
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
