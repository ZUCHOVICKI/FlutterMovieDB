import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:what_to_watch/model/genres_model.dart';
import 'package:what_to_watch/providers/movie_provider.dart';

import '../providers/genre_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreProvider>(context);
    final movieProvider = Provider.of<MovieProvider>(context);
    genreProvider.getGenres();
    final List<Genre> testitems = genreProvider.allGenres;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Genre Select"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            testitems.isEmpty
                ? const CircularProgressIndicator()
                : MultiSelectDialogField(
                    // initialValue: genreProvider.selectedGenres
                    //     .map((e) => MultiSelectItem(e, e.name))
                    //     .toList(),
                    items: testitems
                        .map((e) => MultiSelectItem(e, e.name))
                        .toList(),
                    listType: MultiSelectListType.LIST,

                    onConfirm: (values) {
                      List<Genre> selectedGenres = values as List<Genre>;

                      String ids = '';
                      String names = '';
                      for (var element in selectedGenres) {
                        ids += "${element.id},";
                        names += '${element.name},';
                      }
                      List<String> arguments = [names, ids];
                      values.clear();
                      movieProvider.getMovieDiscovery(withGenres: ids);

                      print(movieProvider.allMovies);

                      Navigator.pushNamed(context, 'movies',
                          arguments: arguments);
                    },
                  ),
          ],
        ));
  }
}

class test {
  final int id;
  final String name;

  test(this.id, this.name);
}
