import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; 
import 'provider/auth_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(

        apiKey: "AIzaSyBG9q2-qcM8m9naKnxFyOkxsG8g7MivW7M",
        authDomain: "test-c171c.firebaseapp.com",
        projectId: "test-c171c",
        storageBucket: "test-c171c.firebasestorage.app",
        messagingSenderId: "239184298536",
        appId: "1:239184298536:web:deb64e687fcbaa7e09eb1d",
        measurementId: "G-C3KELVYR92"

      ),
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  ); 
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (auth.user == null) {
            return const AuthScreen();
          } else {
            return const HomeScreen();
          }
        },
      ),
    );
  }
}
