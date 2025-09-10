import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';

/// Dependency Injection configuration for the application
/// Follows SOLID principles by separating concerns and providing
/// a centralized location for dependency management
class DependencyInjection {
  /// Creates the service providers layer
  /// Services are stateless and can be shared across the app
  static List<RepositoryProvider<dynamic>> get serviceProviders => [];

  /// Creates the repository providers layer
  /// Repositories depend on services and handle data operations
  static List<RepositoryProvider<dynamic>> get repositoryProviders => [
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
        RepositoryProvider<BibleRepository>(
            create: (context) => BibleRepository()),
        RepositoryProvider<BookRepository>(
            create: (context) => BookRepository()),
        RepositoryProvider<ChapterRepository>(
            create: (context) => ChapterRepository()),
        RepositoryProvider<VerseRepository>(
            create: (context) => VerseRepository()),
      ];

  /// Creates the BLoC providers layer
  /// BLoCs depend on repositories and handle business logic
  static List<BlocProvider> get blocProviders => [
        BlocProvider<UserBloc>(
            create: (context) => UserBloc(userRepository: UserRepository())),
        BlocProvider<NotesBloc>(create: (context) => NotesBloc()),
        BlocProvider<SearchBarBookBloc>(
            create: (context) => SearchBarBookBloc()),
        BlocProvider<SearchVersesBloc>(create: (context) => SearchVersesBloc()),
      ];

  /// Combines all providers in the correct dependency order
  /// Services -> Repositories -> BLoCs
  static List<RepositoryProvider<dynamic>> get allProviders => [
        ...serviceProviders,
        ...repositoryProviders,
      ];
}
