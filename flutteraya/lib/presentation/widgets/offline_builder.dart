import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Data/API/now_play_movies_api.dart';
import '../../Data/API/popular_movies_api.dart';
import '../../Data/Repository/now_play_movies_repo.dart';
import '../../Data/Repository/popular_movies_repo.dart';
import '../../cubits/now_playing_movies_cubit/now_playing_movies_cubit.dart';
import '../../cubits/popular_movies_cubit/popular_movies_cubit.dart';
import '../screens/main_screen.dart';
import '../screens/search_screen.dart';

class OfllineBuilder extends StatefulWidget {

  const OfllineBuilder({super.key});

  @override
  State<OfllineBuilder> createState() => _OfllineBuilderState();
}

class _OfllineBuilderState extends State<OfllineBuilder> {
  final _screen = [
    MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              PopularMoviesCubit(PopularMoviesRepo(PopularMoviesAPI()))),
      BlocProvider(
          create: (conetext) => NowPlayingMoviesCubit(
              NowPlayingMoviesRepo(NowPlayingMoviesAPI())))
    ], child: MainScreen()),
    SearchScreen()
  ];

  int _cur = 0;

  @override
  Widget build(BuildContext context) {
    return  OfflineBuilder(
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: "Poppins",
            ),
            debugShowCheckedModeBanner: false,
            home: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.black,
                  bottomNavigationBar: CurvedNavigationBar(
                    index: _cur,
                    // Use this to update the Bar giving a position
                    onTap: (index) {
                      setState(() {
                        _cur = index;
                      });
                    },
                    items: [
                      Icon(Icons.home),
                      Icon(Icons.search),
                    ],
                    height: 40.h,
                    buttonBackgroundColor: Colors.grey,
                    backgroundColor: Colors.transparent,
                    color: Colors.grey,
                    animationDuration: Duration(milliseconds: 300),
                  ),
                  extendBody: true,
                  body: _screen[_cur],
                )),
          );
        } else
          return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("images/offline.png"),
                      Text("Please Check Your Wifi")
                    ],
                  )));
      },
      child: Container(
        child: Text("What to show"),
      ),
    );
  }
}
