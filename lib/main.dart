import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/services/services.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await HiveService.initializeHive();

  runApp(const BibleApp());
}

class BibleApp extends StatelessWidget {
  const BibleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(userRepository: UserRepository()),
        ),
        BlocProvider<NotesBloc>(create: (_) => NotesBloc()),
        BlocProvider<SearchBarBookBloc>(create: (_) => SearchBarBookBloc()),
        BlocProvider<SearchVersesBloc>(create: (_) => SearchVersesBloc()),
      ],
      child: const App(),
    );
  }
}
