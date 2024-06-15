import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteraya/Data/Model/movie_detail_model.dart';
import 'package:flutteraya/Data/Model/movie_videos_model.dart';
import 'package:flutteraya/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  MovieDetails({required this.movie});

  Future<List> movieVideos() async {
    Dio dio = Dio();
    try {
      final Response resp = await dio.get(
          "https://api.themoviedb.org/3/movie/${movie.id}/videos" + api_key);
      print("From dio =========================");
      print(resp.data);

      if (resp.data == null || resp.data["results"] == null) {
        print("No results found in response.");
        return [];
      }

      List<dynamic> finalData = resp.data["results"];
      return finalData.map((e) => MovieVideosModel.fromJson(e)).toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // final PopularMovies popularMovie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 500.h,
            leading: IconButton(
              icon:
                  Icon(Icons.navigate_before, color: Colors.white, size: 40.sp),
              onPressed: () => Navigator.pop(context),
            ),
            pinned: true,
            stretch: false,
            backgroundColor: Colors.grey,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 40.w),
              title: Text(
                movie.title!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
                textAlign: TextAlign.center,
              ),
              background: Hero(
                tag: '${movie.id}',
                child: Image.network(
                  "https://image.tmdb.org/t/p/original/" + movie.posterPath!,
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
                    movie.overview!,
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
                    "Vote Average : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${movie.voteAverage}",
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
                    "${movie.releaseDate}",
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
                    "More Videos : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            FutureBuilder(
                future: movieVideos(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No results found"));
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          MovieVideosModel video = snapshot.data![index];
                          return Link(
                            target: LinkTarget.self,
                            uri: Uri.parse("https://www.youtube.com/watch?v=${video.key}"),
                            builder:(context, followLink)=> InkWell(
                              onTap: followLink,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: ListTile(
                                  leading: FaIcon(FontAwesomeIcons.youtube,color:Colors.red,size: 24.sp,),
                                  title: Text(video.name!),
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
            SizedBox(
              height: 50.h,
            )
          ])),
        ],
      ),
    );
  }
}
