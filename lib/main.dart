import 'package:bible_app/core/core.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  // Initialize app services and dependencies
  final initializationSuccess = await AppInitializer.initialize();

  if (!initializationSuccess) {
    // In production, you might want to show an error screen
    return;
  }

  runApp(const BibleApp());
}

class BibleApp extends StatelessWidget {
  const BibleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: DependencyInjection.allProviders,
      child: MultiBlocProvider(
        providers: DependencyInjection.blocProviders,
        child: const App(),
      ),
    );
  }
}
