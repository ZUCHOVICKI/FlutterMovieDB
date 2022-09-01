import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:what_to_watch/model/models.dart';

class MovieDescriptionScreen extends StatelessWidget {
  const MovieDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Result movie = ModalRoute.of(context)?.settings.arguments as Result;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
            // movie: movie,
            movie: movie),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterTitle(
            movie: movie,
          ),
          _Overview(movie: movie),
        ])),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Result movie;
  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.amber,
      expandedHeight: 100,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            movie.title,
            // movie.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('lib/assets/Loading.gif'),
          image: NetworkImage(
              "https://image.tmdb.org/t/p/w500/${movie.posterPath}"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterTitle extends StatelessWidget {
  final Result movie;
  const _PosterTitle({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage('lib/assets/Loading.gif'),
            image: NetworkImage(
                "https://image.tmdb.org/t/p/w500/${movie.posterPath}"),
            height: 125,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                // movie.title,
                style: themeText.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                movie.originalTitle,
                style: themeText.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_border_outlined,
                    size: 15,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    // "${movie.voteAverage}",
                    "${movie.voteAverage}",
                    style: themeText.caption,
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _Overview extends StatelessWidget {
  final Result movie;
  const _Overview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
