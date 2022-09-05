import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_to_watch/pages/pages.dart';
import 'package:what_to_watch/providers/genre_provider.dart';
import 'package:what_to_watch/providers/movie_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => GenreProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MovieProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreProvider>(context);

    genreProvider.getGenres();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'movies': (context) => const MovieScreen(),
        'description': (context) => const MovieDescriptionScreen(),
      },
    );
  }
}
