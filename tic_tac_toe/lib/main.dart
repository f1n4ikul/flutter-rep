import 'package:flutter/material.dart';
import 'package:tic_tac_toe/feature/game/presentation/tic_tac_toe_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крестики-нолики Elementary',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const TicTacToeScreen(),
    );
  }
}
