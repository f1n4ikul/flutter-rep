import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import '../../../domain/entities/user.dart';
import '../../../presentation/blocs/user_bloc/user_bloc.dart';
// import '../../../presentation/blocs/user_bloc/user_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120F27),
      appBar: AppBar(
        title: const Text("Пользователи"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Поиск
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF764BA2).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Поиск по ID, имени или email",
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
                onChanged: (query) {
                  context.read<UserBloc>().add(FilterUsers(query));
                },
              ),
            ),
            const SizedBox(height: 20),

            // Список пользователей
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.purpleAccent));
                  } else if (state is UserLoaded) {
                    final filteredUsers = state.users.where((user) {
                      final query = _searchController.text.toLowerCase();
                      return user.id.toString().contains(query) ||
                          user.name.toLowerCase().contains(query) ||
                          user.email.toLowerCase().contains(query);
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: GlassCard(user: user),
                        );
                      },
                    );
                  } else if (state is UserError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 16),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Карточка пользователя с эффектом glassmorphism
class GlassCard extends StatelessWidget {
  final User user;

  const GlassCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent.withOpacity(0.7),
                radius: 28,
                child: Text(
                  user.id.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                user.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                user.email,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
