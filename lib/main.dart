import 'package:batol_reem_2/pages/Profile_page.dart';
import 'package:batol_reem_2/pages/tips.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:batol_reem_2/providers/auth_provider.dart';
import 'package:batol_reem_2/pages/home_page.dart';
import 'package:batol_reem_2/pages/signin_page.dart';
import 'package:batol_reem_2/pages/signup_page.dart';
// Import the profile page

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignupPage(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => SigninPage(),
      ),
      GoRoute(
        path: '/profile', // Route to the profile page
        builder: (context, state) => ProfilePage(),
      ),
      GoRoute(
        path: '/tips', // Route to the profile page
        builder: (context, state) => Tips(),
      ),
    ],
  );
}
