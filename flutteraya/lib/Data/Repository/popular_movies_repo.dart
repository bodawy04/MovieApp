import 'package:flutteraya/Data/API/popular_movies_api.dart';
import 'package:flutteraya/Data/Model/popular_movies_model.dart';

class PopularMoviesRepo {
  PopularMoviesAPI popularMoviesAPI;
  PopularMoviesRepo(this.popularMoviesAPI);

  Future<List<PopularMovies>> getElements() async {
    List movies = await popularMoviesAPI.getMovies();

    return movies.map((e) => PopularMovies.fromJson(e)).toList();
  }
}
