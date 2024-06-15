import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteraya/presentation/screens/details_screen.dart';

import '../../cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';

class NowPlayingMoviesBlocBuilder extends StatelessWidget {
  late dynamic nowPlayingMovies;

  NowPlayingMoviesBlocBuilder({super.key, required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
        builder: (context, state) {
      nowPlayingMovies =
          BlocProvider.of<NowPlayingMoviesCubit>(context).loaded();
      if (state is NowPlayingMoviesLoaded) {
        // print(state.loaded);
        return state.loaded == "error"
            ? Center(
                child: Text("ERROR"),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.sp),
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
                            (i) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieDetails(
                                                movie: nowPlayingMovies[i])));
                                  },
                                  child: Hero(
                                    tag: "${nowPlayingMovies[i].id}",
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      width: 120.w,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              height: 150.h,
                                              width: 110.w,
                                              child: FadeInImage(
                                                placeholderFit:
                                                    BoxFit.scaleDown,
                                                placeholder: AssetImage(
                                                    "images/loading.gif"),
                                                image: NetworkImage(
                                                    "https://image.tmdb.org/t/p/original/" +
                                                        nowPlayingMovies[i]
                                                            .posterPath),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))),
                  ),
                ],
              );
      } else
        return Container();
    });
  }
}
