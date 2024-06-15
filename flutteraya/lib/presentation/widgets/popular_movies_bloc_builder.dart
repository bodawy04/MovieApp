import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteraya/presentation/widgets/top_movie_stack.dart';

import '../../cubits/popular_movies_cubit/popular_movies_cubit.dart';
import '../screens/details_screen.dart';

class PopularMoviesBlocBuilder extends StatelessWidget {
  late dynamic popularMovies;

  PopularMoviesBlocBuilder({super.key, required this.popularMovies});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
        builder: (context, state) {
      popularMovies = BlocProvider.of<PopularMoviesCubit>(context).loaded();
      late dynamic popularMovie = popularMovies.removeAt(0);
      if (state is PopularMoviesLoaded) {
        // print(state.loaded);
        return state.loaded == "error"
            ? Center(
                child: Text("ERROR"),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopMovieStack(popularMovie: popularMovie),
                  Padding(
                    padding: EdgeInsets.all(15.sp),
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
                                            builder: (context) => MovieDetails(
                                                movie:popularMovies[i])));
                                  },
                                  child: Hero(
                                    tag: "${popularMovies[i].id}",
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
                                                placeholderFit: BoxFit.scaleDown,

                                                placeholder: AssetImage(
                                                    "images/loading.gif"),
                                                image: NetworkImage(
                                                    "https://image.tmdb.org/t/p/original/" +
                                                        popularMovies[i]
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
