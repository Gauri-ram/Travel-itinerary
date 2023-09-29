import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ninja_id/screens/home_screen.dart';
import 'package:ninja_id/screens/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        'home': (context) => HomeScreen(username: 'Guest User',),
      },
    ),
  );
}
