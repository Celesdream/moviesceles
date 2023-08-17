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

  //el id es un int
  Map<int,List<Cast>> moviesCast = {};


  int _popularPage = 0;


  MoviesProvider() 
  {
    //print("MoviesProvider inicializdo");
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String>_getJsonData(String endpoint,[int page =1 ]) async
  {
    final url = Uri.https(_baseUrl,endpoint,{'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final  response = await http.get(url);
    return response.body;

  }

  getOnDisplayMovies() async 
  {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    //siemore hay que maoear de esta foirma
    onDisplayMovies = nowPlayingResponse.results;

    //si hay un cambio en la data esta funcion le avisa a los widgets
    notifyListeners();
  }

  getPopularMovies() async 
  {
    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    //desectruturamnis
    popularMovies = [...popularMovies,...popularResponse.results];

    //si hay un cambio en la data esta funcion le avisa a los widgets
    //print(popularMovies[0]);
    notifyListeners();
  }

  Future<List<Cast>>getMovieCast(int movieId) async
  {
    if(moviesCast.containsKey(movieId))
    {
      return moviesCast[movieId]!;
    }

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');

    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }


  Future<List<Movie>>searchMovies(String query) async
  {
    final url = Uri.https(_baseUrl, '3/search/movie',{
      'api_key' : _apiKey,
      'language' : _language,
      'query' : query,
    });

    final response = await http.get(url);
    final search_response = SearchResponse.fromJson(response.body);

    return search_response.results;

  }
  
}
