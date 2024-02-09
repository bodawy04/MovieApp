import 'package:bloc/bloc.dart';
import 'package:flutteraya/Data/Repository/now_play_movies_repo.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/now_play_movies_model.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final NowPlayingMoviesRepo nowPlayingMoviesRepo;
  late List<NowPlayingMovies> movies;

  NowPlayingMoviesCubit(this.nowPlayingMoviesRepo)
      : super(NowPlayingMoviesInitial());

  dynamic loaded() {
    try {
      nowPlayingMoviesRepo.getElements().then((value) {
        emit(NowPlayingMoviesLoaded(value));
        movies = value;
      });
      return movies;
    } catch (e) {
      emit(NowPlayingMoviesLoading());
    }
  }
}
