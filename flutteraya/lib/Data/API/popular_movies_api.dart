import 'package:dio/dio.dart';
import 'package:flutteraya/constants.dart';

class PopularMoviesAPI {
  late Dio dio;

  PopularMoviesAPI() {
    dio = Dio();
  }

  Future<dynamic> getMovies() async {
    try {
      final Response resp = await dio.get(api+"popular"+api_key);
      return resp.data["results"];
    } catch (e) {
      return [];
    }
  }
}
