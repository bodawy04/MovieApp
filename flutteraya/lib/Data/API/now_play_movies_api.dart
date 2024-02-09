import 'package:dio/dio.dart';
import 'package:flutteraya/constants.dart';

class NowPlayingMoviesAPI {
  late Dio dio;

  NowPlayingMoviesAPI() {
    dio = Dio();
  }

  Future<dynamic> getMovies() async {
    try {
      final Response resp = await dio.get(api+"now_playing"+api_key);
      return resp.data["results"];
    } catch (e) {
      return [];
    }
  }
}