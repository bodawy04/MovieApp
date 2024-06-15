import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopMovieStack extends StatelessWidget {
  late dynamic popularMovie;

 TopMovieStack({super.key,required this.popularMovie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * (3 / 2),
              child: FadeInImage(
                placeholderFit: BoxFit.scaleDown,
                placeholder: AssetImage("images/loading.gif",),
                image: NetworkImage("https://image.tmdb.org/t/p/original/" +
                    popularMovie.posterPath),
                fit: BoxFit.cover,
              ),),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * (3 / 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    stops: [0.7,0.9 ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              )),
        ),
        Positioned(
            bottom: 80.h,
            left: 20.w,
            child: Container(
              width: MediaQuery.of(context).size.width - 40.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    popularMovie.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    popularMovie.overview,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 12.sp),
                  ),
                ],
              ),
            )),
        Positioned(
            top: 20.h,
            left: 20.w,
            child: Stack(
              children: [
                Text(
                  "#1 Movie",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    backgroundColor: Colors.transparent,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.white,
                  ),
                ),Text(
                  "#1 Movie",
                  style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    // fontSize: 20,
                      color: Colors.transparent
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
