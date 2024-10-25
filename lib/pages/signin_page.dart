import 'package:batol_reem_2/models/user.dart';
import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign in",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            ClipOval(
              child: Image.asset(
                'assets/image/meditation_image1.jpg',
                width: 300, // Increased width
                height: 300, // Increased height
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20), // Increased space
            const Text(
              'Here to begin your journey',
              style: TextStyle(
                color: Colors.grey, // Dark gray color
                fontWeight: FontWeight.bold,
                fontSize: 20, // Increased font size
              ),
            ),
            const SizedBox(height: 30), // Space between text and username

            // Username Input
            TextField(
              decoration: const InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(),
              ),
              controller: usernameController,
            ),
            const SizedBox(height: 20), // Space between username and password

            // Password Input
            TextField(
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 30), // Space before the button

            // Sign In Button
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signin(
                  user: User(
                    username: usernameController.text,
                    password: passwordController.text,
                    imagePath: 'assets/image/defult.png',
                  ),
                );
                GoRouter.of(context).pop(); // Navigate back to home page
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 20), // Space between button and signup prompt

            // Message for users without an account
            const Text(
              "If you don't have an account, please sign up.",
              style: TextStyle(
                color: Colors.grey, // Change this color as needed
                fontWeight: FontWeight.bold,
                fontSize: 16, // You can adjust the font size as well
              ),
            ),
            const SizedBox(
                height: 20), // Space between message and sign up prompt

            // Sign Up Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("You don't have an account? "),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context)
                        .push('/signup'); // Navigate to Sign Up page
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
