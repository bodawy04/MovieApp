import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutteraya/presentation/widgets/offline_builder.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
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
        return MaterialApp(
            theme: ThemeData(
              fontFamily: "Poppins",
            ),
            debugShowCheckedModeBanner: false,
            home: SafeArea(child: OfllineBuilder()));
      },
    );
  }
}
