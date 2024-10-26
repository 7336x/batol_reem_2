import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/signin_page.dart';
import 'pages/signup_page.dart';
import 'pages/music_page.dart'; // Import MusicPage
//import 'pages/tipsListPage.dart';
//import 'pages/tips.dart'; // This should be your Tips page
import 'providers/auth_provider.dart';
import 'services/tips_services.dart'; // Import TipService
import 'services/yoga_music_service.dart'; // Import YogaMusicService
import 'providers/yoga_music_provider.dart'; // Import YogaMusicProvider
import 'pages/ meditation_page.dart';
import 'pages/create_yoga_music_page.dart';
import 'pages/yoga_page.dart';
import 'pages/Tipss.dart';
// Import the DioClient file

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        Provider<DioClient>(create: (_) => (DioClient())), // Provide TipService
        ChangeNotifierProvider<YogaMusicProvider>(
          create: (_) => YogaMusicProvider(
              YogaMusicService(Dio())), // Provide YogaMusicProvider
        ),
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

  final GoRouter _router = GoRouter(routes: [
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
      path: '/yoga',
      builder: (context, state) => YogaPage(),
    ),
    GoRoute(
      path: '/music',
      builder: (context, state) => MusicPage(),
    ),
    GoRoute(
      path: '/meditation',
      builder: (context, state) => MeditationPage(),
    ),
    GoRoute(
      path: '/tips', // Route to the Tipss page
      builder: (context, state) => TipsMainPage(),
    ),
    //   GoRoute(
    //     path: '/tips', // Route to the Tips page
    //     builder: (context, state) => Tips(),
    //   ),
    //   GoRoute(
    //     path: '/tipslist', // Route to the TipsListPage
    //     builder: (context, state) => TipsListPage(),
    //   ),
    // ],
  ]);
}

class DioClient {
  final Dio _dio = Dio();

  // Example method to make a GET request
  Future<Response> getRequest(String path) async {
    return await _dio.get(path);
  }

  // You can add other methods like POST, PUT, DELETE, etc.
}
