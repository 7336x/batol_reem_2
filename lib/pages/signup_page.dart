import 'dart:io';
import 'package:batol_reem_2/models/user.dart';
import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  File? _selectedImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold title
            fontSize: 24, // Larger font size for the title
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Profile Label
              const Text(
                "Put image profile:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              const SizedBox(height: 10), // Space between label and image

              // Profile Image
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 100, // Bigger image
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage('assets/image/defult.png')
                          as ImageProvider, // Default image
                ),
              ),
              const SizedBox(
                  height: 30), // Space between avatar and form fields

              // Username Input
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
                controller: usernameController,
              ),
              const SizedBox(height: 20), // Space between fields

              // Password Input
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 30), // Space before button

              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).signup(
                    user: User(
                      username: usernameController.text,
                      password: passwordController.text,
                      imagePath: _selectedImage?.path ??
                          'assets/image/defult.png', // Use default image path if no image is selected
                    ),
                  );
                  GoRouter.of(context).pop();
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Slightly larger and bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
