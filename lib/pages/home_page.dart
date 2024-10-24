// import 'package:batol_reem_2/providers/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//       ),

//       body: const Center(
//         child: Text("Welcome to the Home Page"),
//       ),
//     );
//   }
// }
import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

// // TODO Delete this
// void main() {
//   runApp(const HomePage());
// }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  // static const List<Widget> _pages = <Widget>[
  //   Center(
  //       child: Text('Relaxation Meditation', style: TextStyle(fontSize: 24))),
  //   Center(
  //       child: Text('Mindfulness Meditation', style: TextStyle(fontSize: 24))),
  //   Center(child: Text('Breathing Meditation', style: TextStyle(fontSize: 24))),
  //   Center(child: Text('Sleep Meditation', style: TextStyle(fontSize: 24))),
  // ];

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
        toolbarHeight: 180, // Increased AppBar height
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
                          decoration: const BoxDecoration(color: Colors.blue),
                          child: Text("Welcome ${authProvider.user.username}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Signout'),
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
                          trailing: const Icon(Icons.person_add),
                          title: const Text('Signup'),
                          onTap: () {
                            // Navigate to the signup page
                            GoRouter.of(context).push('/signup');
                          },
                        ),
                        ListTile(
                          title: const Text("Signin"),
                          trailing: const Icon(Icons.login),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Focus on your Inner Peace',
              style: TextStyle(
                fontSize: 26, // Larger text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildMeditationCard(context, 'Tips', Icons.tips_and_updates),
                _buildMeditationCard(
                    context, 'Yoga video', Icons.self_improvement),
                _buildMeditationCard(context, 'Music', Icons.music_note),
                _buildMeditationCard(context, 'Meditation', Icons.spa),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Expanded(
          //   child: _pages[_selectedIndex], // Display selected page content
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates,
                color: Colors.blueAccent), // Changed icon color
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement,
                color: Colors.blueAccent), // Changed icon color
            label: 'Yoga video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note,
                color: Colors.blueAccent), // Changed icon color
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.spa, color: Colors.blueAccent), // Changed icon color
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
      margin: const EdgeInsets.symmetric(
          horizontal: 12.0), // Slightly larger margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 180, // Increased card width
        padding: const EdgeInsets.all(20.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,
                size: 50, color: Colors.blueAccent), // Increased icon size
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20, // Larger text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
