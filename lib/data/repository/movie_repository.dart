import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviapitask/data/Model/movieapi.dart';

abstract class MovieRepository {
  Future getMoviedetail(String name);
}

class MovieRepositoryImpl implements MovieRepository {
  @override
  Future getMoviedetail(String name) async {
    http.Response response = await http
    
        .get(Uri.parse('https://www.omdbapi.com/?t=$name&apikey=c684402a'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      MovieApi moviapi = MovieApi.fromJson(body);

      return moviapi;
    } else {
      throw Exception();
    }
  }
}
