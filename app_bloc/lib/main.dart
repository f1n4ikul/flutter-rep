import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_bloc/domain/usecases/get_users.dart';
import 'package:app_bloc/data/repositories/user_repository_impl.dart';
import 'package:app_bloc/data/datasources/user_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'presentation/blocs/user_bloc/user_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            getUsers: GetUsers(
              UserRepositoryImpl(
                remoteDataSource: UserRemoteDataSourceImpl(
                  client: http.Client(),
                ),
              ),
            ),
          )..add(LoadUsers()),
        ),
      ],
      child: MaterialApp(
        title: 'User App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}
