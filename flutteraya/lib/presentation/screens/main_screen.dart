import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteraya/cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';
import 'package:flutteraya/presentation/widgets/now_playing_movies_bloc_builder.dart';
import 'package:flutteraya/presentation/widgets/popular_movies_bloc_builder.dart';
import '../../cubits/popular_movies_cubit/popular_movies_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late dynamic popularMovies = [];
  late dynamic nowPlayingMovies = [];

  @override
  void initState() {
    // print(movies);
    super.initState();
    BlocProvider.of<PopularMoviesCubit>(context).loaded();
    BlocProvider.of<NowPlayingMoviesCubit>(context).loaded();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            PopularMoviesBlocBuilder(
              popularMovies: popularMovies,
            ),
            SizedBox(
              height: 20.h,
            ),
            NowPlayingMoviesBlocBuilder(nowPlayingMovies: nowPlayingMovies)
          ],
        ));
  }
}
