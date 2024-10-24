import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: Drawer(
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
                        leading: const Icon(Icons.person_add),
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
      body: const Center(
        child: Text("Welcome to the Home Page"),
      ),
    );
  }
}
