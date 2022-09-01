import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_to_watch/providers/movie_provider.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  int atEnd = 0;
  final ScrollController scrollcontrol = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final List<String> arguments =
        ModalRoute.of(context)?.settings.arguments as List<String>;
    final size = MediaQuery.of(context).size;

    scrollcontrol.addListener(() {
      int block = 0;
      if (scrollcontrol.position.pixels + 150 >=
              scrollcontrol.position.maxScrollExtent &&
          block == 0) {
        movieProvider.currentPage += 1;
        block = 1;
        movieProvider.getMovieDiscovery(
            page: movieProvider.currentPage, withGenres: arguments[1]);

        setState(() {});
        block = 0;
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(arguments[0]),
        ),
        body: movieProvider.allMovies.isNotEmpty
            ? ListView.builder(
                controller: scrollcontrol,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    width: double.infinity,
                    height: size.height * .6,
                    child: GestureDetector(
                      onTap: () {
                        movieProvider
                            .getMovieByID(movieProvider.allMovies[index].id);
                        Navigator.pushNamed(context, 'description',
                            arguments: movieProvider.allMovies[index]);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: movieProvider.allMovies[index].posterPath ==
                                    null
                                ? const Image(
                                    image: AssetImage('lib/assets/Loading.gif'))
                                : FadeInImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500/${movieProvider.allMovies[index].posterPath}"),
                                    fit: BoxFit.cover,
                                    placeholder: const AssetImage(
                                        'lib/assets/Loading.gif'),
                                  ),
                          ),
                          Text(movieProvider.allMovies[index].title)
                        ],
                      ),
                    ),
                  );
                },
                itemCount: movieProvider.allMovies.length,
              )
            : const CircularProgressIndicator());
  }
}
