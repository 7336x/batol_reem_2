import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meditation Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MeditationHomePage(),
    );
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
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meditation Time',
          style: GoogleFonts.lora(
            fontSize: 35,
            fontWeight: FontWeight.w600, // SemiBold
            fontStyle: FontStyle.italic, // Italic style
            color: Colors.white,
          ),
        ),
        toolbarHeight: 400, // Increased AppBar height
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: FutureBuilder(
            future: context.read<AuthProvider>().initializeAuth(),
            builder: (context, dataSnapshot) => Consumer<AuthProvider>(
              builder: (context, authProvider, child) => authProvider.isAuth()
                  ? ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: const BoxDecoration(
                            color: Colors.transparent, // Transparent header
                          ),
                          child: Text(
                            "Welcome ${authProvider.user.username}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout,
                              color: Colors.blueAccent),
                          title: const Text(
                            'Signout',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            authProvider.signout();
                            GoRouter.of(context)
                                .pop(); // Pop back to the home page
                          },
                        ),
                      ],
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ListTile(
                          trailing: const Icon(Icons.person_add,
                              color: Colors.blueAccent),
                          title: const Text(
                            'Signup',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            GoRouter.of(context).push('/signup');
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Signin",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing:
                              const Icon(Icons.login, color: Colors.blueAccent),
                          onTap: () {
                            GoRouter.of(context).push('/signin');
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Focus on your Inner Peace',
              style: TextStyle(
                fontSize: 26, // Larger text size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // GridView for meditation cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Number of columns in the grid
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                crossAxisSpacing: 16.0, // Space between columns
                mainAxisSpacing: 16.0, // Space between rows
                children: [
                  _buildMeditationCard(context, 'Tips', Icons.tips_and_updates),
                  _buildMeditationCard(
                      context, 'Yoga video', Icons.self_improvement),
                  _buildMeditationCard(context, 'Music', Icons.music_note),
                  _buildMeditationCard(context, 'Meditation', Icons.spa),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates, color: Colors.blueAccent),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement, color: Colors.blueAccent),
            label: 'Yoga video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note, color: Colors.blueAccent),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa, color: Colors.blueAccent),
            label: 'Meditation',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildMeditationCard(
      BuildContext context, String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
