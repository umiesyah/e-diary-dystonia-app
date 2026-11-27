import 'package:dystoniadiary/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Diary Dystonia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 243, 251, 244)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}



class palletcolor{
  static Color lighter = Color.fromARGB(255,221, 230, 237);
  static Color light   = Color.fromARGB(255, 164, 191, 157);
  static Color dark    = Color.fromARGB(255, 77, 148, 97);
  static Color darker  = Color.fromARGB(255, 7, 115, 18);
}
