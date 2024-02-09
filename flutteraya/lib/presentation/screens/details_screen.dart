import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteraya/Data/Model/movie_detail_model.dart';
import 'package:flutteraya/Data/Model/popular_movies_model.dart';
import 'package:flutteraya/constants.dart';

class MovieDetails extends StatefulWidget {
  // int _movieID;
  // Future<MovieDetailsModel> movieDetails() async {
  //   MovieDetailsModel movieDetailsModel;
  //   Dio dio = Dio();
  //   Response resp;
  //   resp = await dio.get(api + "${_movieID}" + api_key);
  //   movieDetailsModel = MovieDetailsModel.fromJson(resp.data);
  //   return movieDetailsModel;
  // }

  // MovieDetails(this._movieID, {super.key}){
  //   movieDetails();
  // }
  final PopularMovies popularMovies;

  MovieDetails(this.popularMovies);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 500.h,
            leading: IconButton(
              icon:
                  Icon(Icons.navigate_before, color: Colors.black, size: 40.sp),
              onPressed: () => Navigator.pop(context),
            ),
            pinned: true,
            stretch: false,
            backgroundColor: Colors.grey,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.popularMovies.title!,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp),
              ),
              background: Hero(
                tag: '${widget.popularMovies.id}',
                child: Image.network(
                  "https://image.tmdb.org/t/p/original/" +
                      widget.popularMovies.posterPath!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Overview",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    widget.popularMovies.overview!,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Runtime : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "100 minutes",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Revenue : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "100000000\$",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Release Date : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.popularMovies.releaseDate}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400.h,
            )
          ])),
        ],
      ),
    );
  }
}
