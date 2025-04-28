import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  // Method to handle the signup process
  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      // Attempt to call the signup method from the provider
      await authProvider.signup(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      // If signup is successful, navigate to the Home page
      if (authProvider.isAuthenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ), // Navigate to Home
        );
      }
    } catch (error) {
      // If an error occurs during signup, show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()), // Show error message
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Instagram Logo
            Center(
              child: Image.asset(
                'assets/images/instagram_logo.png', // Make sure the image is in the correct location
                width: 120, // Adjust the width as needed
              ),
            ),
            const SizedBox(height: 40), // Space between logo and input fields
            // Username Input
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),

            // Email Input
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),

            // Password Input
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),

            // Signup Button
            ElevatedButton(
              onPressed:
                  _isLoading ? null : _signup, // Disable button while loading
              child:
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Signup'),
            ),
            const SizedBox(height: 20),

            // Link to Login page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
