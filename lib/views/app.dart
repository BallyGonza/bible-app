import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/theme.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible App',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (user) {
              return HomeScreen(
                user: user,
              );
            },
          );
        },
      ),
    );
  }
}
