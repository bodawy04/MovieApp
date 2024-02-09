part of 'now_playing_movies_cubit.dart';

@immutable
abstract class NowPlayingMoviesState {}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoaded extends NowPlayingMoviesState{
  final dynamic loaded;
  NowPlayingMoviesLoaded(this.loaded);
}

class NowPlayingMoviesLoading extends NowPlayingMoviesState{}
