import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    // Check if the user object is null
    if (user == null) {
      return Center(
        child: Text('User information is not available.'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.lora(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: const Color.fromARGB(255, 118, 18, 52),
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 80, // Increased radius for a bigger photo
              backgroundImage:
                  NetworkImage(user.imagePath ?? 'assets/image/default.png'),
            ),
            const SizedBox(height: 16),
            // Username
            Text(
              user.username ?? 'No Name',
              style: TextStyle(
                fontSize: 24, // Increased font size
                fontWeight: FontWeight.bold,
                color:
                    const Color.fromARGB(255, 118, 18, 52), // Dark pink color
              ),
            ),
            const SizedBox(height: 20),
            // Finished Exercises section
            Text(
              "Your Finished Exercises here :",
              style: TextStyle(
                fontSize: 20, // Increased font size
                fontWeight: FontWeight.bold,
                color:
                    const Color.fromARGB(255, 118, 18, 52), // Dark pink color
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Change this to the number of finished exercises
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Exercise ${index + 1}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
