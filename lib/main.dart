import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test/Bloc/users_bloc.dart';
import 'package:users_test/UI/LoginPage.dart';
import 'package:users_test/UI/SignupPage.dart';

import 'UI/UsersListPage.dart';

void main() {
  runApp(const MainAnsistor());
}

class MainAnsistor extends StatelessWidget {
  const MainAnsistor({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Users App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(providers: [
        BlocProvider<UsersBloc>(create: (_) => UsersBloc()),
      ], child: const UsersListPage()),
    );
  }
}
