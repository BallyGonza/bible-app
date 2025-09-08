import 'package:bible_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/theme.dart';
import 'package:bible_app/views/views.dart';

const bool kDebugShowCheckedModeBanner = false;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "DM Sans", "DM Sans");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      // theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      theme: theme.dark(),
      debugShowCheckedModeBanner: kDebugShowCheckedModeBanner,
      home: const HomeBuilder(),
    );
  }
}

class HomeBuilder extends StatelessWidget {
  const HomeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            loaded: (user) => HomeScreen(user: user),
          );
        },
      ),
    );
  }
}
