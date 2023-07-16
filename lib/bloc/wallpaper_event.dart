import 'package:flutter/cupertino.dart';

@immutable
abstract class WallpaperEvent{}

class GetTrendingWallpaperEvent extends WallpaperEvent{
  String? perPage;
  String? pageNo;
  GetTrendingWallpaperEvent({this.perPage, this.pageNo});
}

class GetSearchedWallpaperEvent extends WallpaperEvent{
  String? query;
  String? perPage;
  GetSearchedWallpaperEvent({required this.query, required this.perPage});
}