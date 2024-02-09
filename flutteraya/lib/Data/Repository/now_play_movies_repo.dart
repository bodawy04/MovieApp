import 'package:flutteraya/Data/API/now_play_movies_api.dart';
import 'package:flutteraya/Data/Model/now_play_movies_model.dart';

class NowPlayingMoviesRepo {
  NowPlayingMoviesAPI nowPlayingMoviesAPI;
  NowPlayingMoviesRepo(this.nowPlayingMoviesAPI);

  Future<List<NowPlayingMovies>> getElements() async {
    List movies = await nowPlayingMoviesAPI.getMovies();
    return movies.map((e) => NowPlayingMovies.fromJson(e)).toList();
  }
}
