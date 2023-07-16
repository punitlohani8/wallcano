import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/bloc/wallpaper_bloc.dart';
import 'package:my_wallpaper/repository/repo.dart';
import 'package:my_wallpaper/screens/home_screen.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => WallpaperBloc(repo: WallpaperRepo()),
    child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}