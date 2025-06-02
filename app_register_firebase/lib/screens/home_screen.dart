import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) ...[
              Text('Вы вошли как: ${user.email}'),
              const SizedBox(height: 20),
              const Text('Полный функционал доступен!',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Доступно только авторизованным пользователям
                  _showPremiumFeature(context);
                },
                child: const Text('Премиум функция'),
              ),
            ] else ...[
              const Text('Ограниченный функционал',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showRestrictedFeature(context);
                },
                child: const Text('Базовая функция'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Эта функция доступна только авторизованным пользователям'),
                    ),
                  );
                },
                child: const Text('Премиум функция (недоступна)'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showPremiumFeature(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Премиум функция'),
        content: const Text(
            'Этот функционал доступен только для авторизованных пользователей.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showRestrictedFeature(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Базовая функция'),
        content: const Text('Этот функционал доступен всем пользователям.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
