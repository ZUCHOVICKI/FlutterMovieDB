import 'package:flutter/material.dart';
import 'package:what_to_watch/model/models.dart';
import 'package:http/http.dart' as http;

class MovieProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _APIkey = "430d1f93728146cc054a56d4f54dc2ee";
  String _language = 'es-ES';

  List<Result> allMovies = [];
  List<IndMovie> indMovies = [];
  int _currentPage = 1;

  int get currentPage => _currentPage;

  set currentPage(int page) {
    _currentPage = page;
    // notifyListeners();
  }

  getMovieDiscovery({page = 1, withGenres}) async {
    var url = Uri.https(_baseUrl, '3/discover/movie', {
      'api_key': _APIkey,
      'language': _language,
      'with_genres': withGenres,
      'page': "$page",
      "sort_by": "popularity.desc"
    });

    final response = await http.get(url);

    final movieModel = Movies.fromJson(response.body);

    if (page == 1) {
      allMovies = movieModel.results;
    } else {
      allMovies += [...movieModel.results];
    }

    notifyListeners();
  }

//https://api.themoviedb.org/3/movie/{movie_id}?api_key=430d1f93728146cc054a56d4f54dc2ee&language=en-US
  getMovieByID(id) async {
    IndMovie? returnElement;

    indMovies.forEach((element) {
      if (element.id == id) {
        returnElement = element;
      }
    });
    if (returnElement == null) {
      var url = Uri.https(_baseUrl, '3/movie/$id', {
        'api_key': _APIkey,
        'language': _language,
      });

      final response = await http.get(url);

      final movieModel = IndMovie.fromJson(response.body);

      indMovies.add(movieModel);

      return movieModel;
    }

    return returnElement;
  }
}
