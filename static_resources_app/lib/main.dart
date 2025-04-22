import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Король и Шут',
      theme: ThemeData(
        fontFamily: 'Izhitsa', // Используем подключённый шрифт
        primarySwatch: Colors.blue,
      ),
      home: const ImageScreen(),
    );
  }
}

class ImageScreen extends StatelessWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Король и Шут'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),   
            const SizedBox(height: 32),
            const Text(
              'Изображения:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Image.asset('assets/images/image_1.jpg'),
                  const SizedBox(height: 16),
                  Image.asset('assets/images/image_2.jpg'),
                  const SizedBox(height: 16),
                  Image.asset('assets/images/image_3.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}