import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/services/services.dart';
import 'package:bible_app/views/views.dart';

Future<void> main() async {
  await HiveService.initializeHive();
  runApp(const Main());
}

// This widget initializes the BLoC providers and runs the app.
class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: UserRepository(),
          ),
        ),
      ],
      child: const App(),
    );
  }
}
