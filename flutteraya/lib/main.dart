import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutteraya/Data/API/popular_movies_api.dart';
import 'package:flutteraya/presentation/screens/main_screen.dart';
import 'package:provider/provider.dart';

import 'Data/API/now_play_movies_api.dart';
import 'Data/Repository/now_play_movies_repo.dart';
import 'Data/Repository/popular_movies_repo.dart';
import 'cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';
import 'cubits/popular_movies_cubit/popular_movies_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    PopularMoviesCubit(PopularMoviesRepo(PopularMoviesAPI()))),
              BlocProvider(
                create: (context) =>
                    NowPlayingMoviesCubit(NowPlayingMoviesRepo(NowPlayingMoviesAPI()))),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SafeArea(child: MainScreen()),
            ));
      },
    );
  }
}
