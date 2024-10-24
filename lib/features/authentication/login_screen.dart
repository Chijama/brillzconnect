import 'package:brillzconnect/common/color.dart';
import 'package:brillzconnect/common/text_field.dart';
import 'package:brillzconnect/common/text_style.dart';
import 'package:brillzconnect/features/authentication/forgot_password_screen.dart';
import 'package:brillzconnect/features/authentication/models/user_model.dart';
import 'package:brillzconnect/features/authentication/register_screen.dart';
import 'package:brillzconnect/features/nav_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Variable to track password visibility

  // Simulate login logic
  void login() {
    // Fetch the user from the provider (or use the default user if null)
    final currentUser =
        User.defaultUser(); // Replace with provider logic if needed

    // Get the email and password entered by the user
    final enteredEmail = _emailController.text;
    final enteredPassword = _passwordController.text;

    // Check if the entered credentials match the user
    if (enteredEmail == currentUser.email &&
        enteredPassword == currentUser.password) {
      // Login successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavBar()),
      );
    } else {
      // Show error if credentials are incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid email or password',
            style: TextStyle(color: AppColors.appWhite),
          ),
          backgroundColor: AppColors.appDangerButtonRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back!",
                style:
                    getBlackZodiak(fontsize: 29, fontweight: FontWeight.w600),
              ),
              const SizedBox(height: 15),

              // Email input field
              CustomBoxTextField(
                controller: _emailController,
                label: "Email",
                hintText: 'janedoe@gmail.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              CustomPasswordField(
                controller: _passwordController,
                label: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Login button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Invalid login credentials")),
                    );
                  }
                },
                child: const Text('Login'),
              ),

              // Forgot Password Button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen()),
                  );
                },
                child: const Text("Forgot Password?"),
              ),

              // Register Button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text("Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
