import 'package:flutter/material.dart';
import 'package:what_to_watch/model/models.dart';
import 'package:http/http.dart' as http;

class GenreProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _APIkey = "430d1f93728146cc054a56d4f54dc2ee";
  String _language = 'es-ES';

  List<Genre> allGenres = [];
  // static List<Genre> _selectedGenres = [];

  // List<Genre> get selectedGenres => _selectedGenres;

  // set selectedGenres(List<Genre> genres) {
  //   _selectedGenres.clear();
  //   _selectedGenres = genres;
  //   notifyListeners();
  // }

  getGenres() async {
    var url = Uri.https(_baseUrl, '3/genre/movie/list', {
      'api_key': _APIkey,
      'language': _language,
    });

    final response = await http.get(url);

    final genreModel = Genres.fromJson(response.body);

    allGenres = genreModel.genres;

    notifyListeners();
  }
}
