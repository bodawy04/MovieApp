import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteraya/Data/API/popular_movies_api.dart';
import 'package:flutteraya/Data/Repository/popular_movies_repo.dart';
import 'package:flutteraya/cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';
import 'package:flutteraya/presentation/screens/details_screen.dart';

import '../../Data/Model/popular_movies_model.dart';
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
            popularMovies == []
                ? Center(
                    child: Image.asset("images/loading.gif"),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                            builder: (context, state) {
                          popularMovies =
                              BlocProvider.of<PopularMoviesCubit>(context)
                                  .loaded();
                          late dynamic popularMovie = popularMovies.removeAt(0);
                          if (state is PopularMoviesLoaded) {
                            // print(state.loaded);
                            return state.loaded == "error"
                                ? Center(
                                    child: Text("ERROR"),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20)),
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (3 / 2),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      // scale: 750 / 500,
                                                      image: NetworkImage(
                                                          "https://image.tmdb.org/t/p/original/" +
                                                              popularMovie
                                                                  .posterPath)),
                                                )),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20)),
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (3 / 2),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.black
                                                      ],
                                                      stops: [
                                                        0.2,
                                                        0.9
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter),
                                                )),
                                          ),
                                          Positioned(
                                              bottom: 100.h,
                                              left: 20.w,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      popularMovie.title,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 24.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                      popularMovie.overview,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.grey,
                                                          fontSize: 12.sp),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        child: Text(
                                          "Popular Movies",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Row(
                                            children: List.generate(
                                                popularMovies.length,
                                                (i) => InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MovieDetails(
                                                                        popularMovies[i])));
                                                      },
                                                      child: Hero(
                                                        tag: "${popularMovies[i].id}",
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      6.w),
                                                          width: 120.w,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Container(
                                                                    height: 150.h,
                                                                    width: 100.w,
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            fit: BoxFit
                                                                                .fill,
                                                                            scale: 750 /
                                                                                500,
                                                                            image:
                                                                                NetworkImage("https://image.tmdb.org/t/p/original/" + popularMovies[i].posterPath)))),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                popularMovies[i]
                                                                    .title,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ))),
                                      ),
                                    ],
                                  );
                          } else if (state is PopularMoviesLoading) {
                            return Center(
                              child: Image.asset("images/loading.gif"),
                            );
                          } else
                            return Container();
                        }),
                      ],
                    ),
                  ),
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
                builder: (context, state) {
              nowPlayingMovies =
                  BlocProvider.of<NowPlayingMoviesCubit>(context).loaded();
              if (state is NowPlayingMoviesLoaded) {
                print(state.loaded);
                return state.loaded == "error"
                    ? Center(
                        child: Text("ERROR"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Text(
                              "Now Playing",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 16.sp),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                                children: List.generate(
                                    nowPlayingMovies.length,
                                    (i) => Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 6.w),
                                          width: 120.w,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                    height: 150.h,
                                                    width: 100.w,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            scale: 750 / 500,
                                                            image: NetworkImage(
                                                                "https://image.tmdb.org/t/p/original/" +
                                                                    nowPlayingMovies[
                                                                            i]
                                                                        .posterPath)))),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                nowPlayingMovies[i].title,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ))),
                          ),
                        ],
                      );
              } else if (state is NowPlayingMoviesLoading) {
                return Center(
                  child: Image.asset("images/loading.gif"),
                );
              } else
                return Container();
            }),
          ],
        ));
  }
}
