import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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

    // List of exercises and their corresponding YouTube URLs
    final exercises = [
      {
        'title': 'Push Up',
        'url': 'https://www.youtube.com/watch?v=IODxDxX7oi4'
      },
      {'title': 'Squat', 'url': 'https://www.youtube.com/watch?v=UXJrBgI2VcM'},
      {'title': 'Lunges', 'url': 'https://www.youtube.com/watch?v=QOVaH4Wn8Ew'},
      {'title': 'Plank', 'url': 'https://www.youtube.com/watch?v=pSHjTRCQxIw'},
      {
        'title': 'Burpees',
        'url': 'https://www.youtube.com/watch?v=TU8QYHV6gYQ'
      },
    ];

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
              radius: 80,
              backgroundImage:
                  NetworkImage(user.imagePath ?? 'assets/image/default.png'),
            ),
            const SizedBox(height: 16),
            // Username
            Text(
              user.username ?? 'No Name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 118, 18, 52),
              ),
            ),
            const SizedBox(height: 20),
            // Finished Exercises section
            Text(
              "Your Finished Exercises here:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 118, 18, 52),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              // Open the YouTube link when tapped
                              if (await canLaunch(exercise['url']!)) {
                                await launch(exercise['url']!);
                              } else {
                                throw 'Could not launch ${exercise['url']}';
                              }
                            },
                            child: Text(
                              exercise['title']!,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () async {
                              // Open the YouTube link when tapped
                              if (await canLaunch(exercise['url']!)) {
                                await launch(exercise['url']!);
                              } else {
                                throw 'Could not launch ${exercise['url']}';
                              }
                            },
                            child: Text(
                              exercise['url']!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
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
