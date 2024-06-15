import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Data/Model/movie_detail_model.dart';
import '../../constants.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  Future<List<Movie>> searchMovies() async {
    Dio dio = Dio();
    try {
      final Response resp = await dio.get(
        "https://api.themoviedb.org/3/search/movie" + api_key,
        queryParameters: {
          "query": _searchQuery,
        },
      );
      // print("From dio =========================");
      // print(resp.data);

      if (resp.data == null || resp.data["results"] == null) {
        // print("No results found in response.");
        return [];
      }

      List<dynamic> finalData = resp.data["results"];
      return finalData.map((e) => Movie.fromJson(e)).toList();
    } catch (e) {
      // print("Error: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              onChanged: (text) {
                setState(() {
                  _searchQuery = text;
                });
              },
              style: TextStyle(color: Colors.grey),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                hintText: "Search for something",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            FutureBuilder<List<Movie>>(
              future: searchMovies(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: Colors.grey,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _searchQuery.length != 0
                      ? Center(
                          child: Text(
                          "No results found",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                        ))
                      : Container();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Movie movie = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                          movie: movie,
                                        )));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  placeholderFit: BoxFit.scaleDown,
                                  placeholder: AssetImage("images/loading.gif"),
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/" +
                                          movie.posterPath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(movie.title!),
                              textColor: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
