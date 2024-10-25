import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MeditationHomePage();
  }
}

class MeditationHomePage extends StatefulWidget {
  const MeditationHomePage({Key? key}) : super(key: key);

  @override
  _MeditationHomePageState createState() => _MeditationHomePageState();
}

class _MeditationHomePageState extends State<MeditationHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.isAuth()) {
      setState(() {
        _selectedIndex = index;
      });
      // Navigate to pages directly
      switch (index) {
        case 0:
          GoRouter.of(context).push('/tips');
          break;
        case 1:
          GoRouter.of(context).push('/yoga');
          break;
        case 2:
          GoRouter.of(context).push('/music');
          break;
        case 3:
          GoRouter.of(context).push('/meditation');
          break;
        case 4:
          GoRouter.of(context).push('/profile');
          break;
      }
    } else {
      _showAuthMessage(context);
    }
  }

  void _showAuthMessage(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!authProvider.isAuth()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'You should sign in or sign up, click here or on the drawer.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          action: SnackBarAction(
            label: 'Sign In',
            onPressed: () {
              GoRouter.of(context).push('/signin');
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 192, 226),
      appBar: AppBar(
        title: Text(
          'Meditation Time',
          style: GoogleFonts.lora(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: const Color.fromARGB(255, 118, 18, 52),
          ),
        ),
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: FutureBuilder(
            future: context.read<AuthProvider>().initializeAuth(),
            builder: (context, dataSnapshot) => Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: authProvider.isAuth()
                      ? [
                          DrawerHeader(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Text(
                              "Welcome ${authProvider.user.username}",
                              style: GoogleFonts.lora(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 118, 18, 52),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout,
                                color: Color.fromARGB(255, 118, 18, 52)),
                            title: const Text(
                              'Signout',
                              style: TextStyle(
                                color: Color.fromARGB(255, 118, 18, 52),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            onTap: () {
                              authProvider.signout();
                              GoRouter.of(context).pop();
                            },
                          ),
                        ]
                      : [
                          ListTile(
                            trailing: const Icon(Icons.person_add,
                                color: Color.fromARGB(255, 118, 18, 52)),
                            title: const Text(
                              'Signup',
                              style: TextStyle(
                                color: Color.fromARGB(255, 118, 18, 52),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            onTap: () {
                              GoRouter.of(context).push('/signup');
                            },
                          ),
                          ListTile(
                            title: const Text(
                              "Signin",
                              style: TextStyle(
                                color: Color.fromARGB(255, 118, 18, 52),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            trailing: const Icon(Icons.login,
                                color: Color.fromARGB(255, 118, 18, 52)),
                            onTap: () {
                              GoRouter.of(context).push('/signin');
                            },
                          ),
                        ],
                );
              },
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          _showAuthMessage(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Focus on your Inner Peace',
                style: GoogleFonts.lora(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 118, 18, 52),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 300,
                child: ClipRect(
                  child: Image.asset(
                    'assets/image/yoga_girl.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    _buildMeditationCard(context, 'Tips', Icons.tips_and_updates, 'assets/image/tips_image2.jpeg'),
                    _buildMeditationCard(context, 'Yoga', Icons.self_improvement, 'assets/image/yoga_pose.png'),
                    _buildMeditationCard(context, 'Music', Icons.music_note, 'assets/image/music_image2.jpeg'),
                    _buildMeditationCard(context, 'Meditation', Icons.spa, 'assets/image/meditation_image1.jpg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates,
                color: Color.fromARGB(255, 118, 18, 52)),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement,
                color: Color.fromARGB(255, 118, 18, 52)),
            label: 'Yoga video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note,
                color: Color.fromARGB(255, 118, 18, 52)),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa, color: Color.fromARGB(255, 118, 18, 52)),
            label: 'Meditation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 118, 18, 52)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 118, 18, 52),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildMeditationCard(BuildContext context, String title, IconData icon, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
          if (!authProvider.isAuth()) {
            _showAuthMessage(context);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10.0), // Reduced padding to avoid overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 60, // Adjusted width to avoid overflow
                  height: 60, // Adjusted height to avoid overflow
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.lora(
                  fontSize: 20, // Reduced font size
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 118, 18, 52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
