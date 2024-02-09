import 'package:bloc/bloc.dart';
import 'package:flutteraya/Data/Model/popular_movies_model.dart';
import 'package:meta/meta.dart';
import '../../Data/Repository/popular_movies_repo.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final PopularMoviesRepo popularMoviesRepo;
  late List<PopularMovies> movies;

  PopularMoviesCubit(this.popularMoviesRepo) : super(PopularMoviesInitial());

  dynamic loaded() {
    try {
      popularMoviesRepo.getElements().then((value) {
        emit(PopularMoviesLoaded(value));
        movies = value;
      });
      return movies;
      // else if(movies==[])return "error";
    } catch (e) {
      emit(PopularMoviesLoading());
    }
  }
}
