// import 'package:dio/dio.dart';
//
// class PopularMovies {
//   bool? adult;
//   String? backdropPath;
//   List<int>? genreIds;
//   int? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String? title;
//   bool? video;
//   double? voteAverage;
//   int? voteCount;
//
//   PopularMovies(
//       {this.adult,
//         this.backdropPath,
//         this.genreIds,
//         this.id,
//         this.originalLanguage,
//         this.originalTitle,
//         this.overview,
//         this.popularity,
//         this.posterPath,
//         this.releaseDate,
//         this.title,
//         this.video,
//         this.voteAverage,
//         this.voteCount});
//
//   PopularMovies.fromJson(Map<String, dynamic> json) {
//     adult = json['adult'];
//     backdropPath = json['backdrop_path'];
//     genreIds = json['genre_ids'].cast<int>();
//     id = json['id'];
//     originalLanguage = json['original_language'];
//     originalTitle = json['original_title'];
//     overview = json['overview'];
//     popularity = json['popularity'];
//     posterPath = json['poster_path'];
//     releaseDate = json['release_date'];
//     title = json['title'];
//     video = json['video'];
//     voteAverage = json['vote_average'];
//     voteCount = json['vote_count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['adult'] = this.adult;
//     data['backdrop_path'] = this.backdropPath;
//     data['genre_ids'] = this.genreIds;
//     data['id'] = this.id;
//     data['original_language'] = this.originalLanguage;
//     data['original_title'] = this.originalTitle;
//     data['overview'] = this.overview;
//     data['popularity'] = this.popularity;
//     data['poster_path'] = this.posterPath;
//     data['release_date'] = this.releaseDate;
//     data['title'] = this.title;
//     data['video'] = this.video;
//     data['vote_average'] = this.voteAverage;
//     data['vote_count'] = this.voteCount;
//     return data;
//   }
// }
//
//
// class PopularMoviesAPI {
//   late Dio dio;
//
//   PopularMoviesAPI() {
//     dio = Dio();
//   }
//
//   Future<List> getMovies() async {
//     try {
//       final Response resp = await dio.get("https://api.themoviedb.org/3/movie/popular?api_key=6b25df9f7b414470c1ba323422002ab8");
//       print("------------------------");
//       print(resp.statusCode);
//       return resp.data["results"];
//     } catch (e) {
//       print("=++++++++++++++++++++++++++++++");
//       print(e.toString());
//       return [];
//     }
//   }
// }
//
// class PopularMoviesRepo {
//   PopularMoviesAPI popularMoviesAPI;
//   PopularMoviesRepo(this.popularMoviesAPI);
//
//   Future<List<PopularMovies>> getElements() async {
//     List movies = await popularMoviesAPI.getMovies();
//     print("===============================");
//     print(movies.runtimeType);
//     print("===============================");
//     return movies.map((e) => PopularMovies.fromJson(e)).toList();
//   }
// }
//
import 'constants.dart';

void main() {
  print(api + "866398" + api_key);
}