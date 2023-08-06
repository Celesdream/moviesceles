import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier 
{
  final String _apiKey = 'de91a6a855842fb4dcc097b4ecc41f43';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];


  MoviesProvider() 
  {
    //print("MoviesProvider inicializdo");
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async 
  {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    //siemore hay que maoear de esta foirma
    onDisplayMovies = nowPlayingResponse.results;

    //si hay un cambio en la data esta funcion le avisa a los widgets
    notifyListeners();
  }

  getPopularMovies() async 
  {
    var url = Uri.https(_baseUrl, '3/movie/popular', {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    //desectruturamnis
    popularMovies = [...popularMovies,...popularResponse.results];

    //si hay un cambio en la data esta funcion le avisa a los widgets
    //print(popularMovies[0]);
    notifyListeners();
  }
  
}
