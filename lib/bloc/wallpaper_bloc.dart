
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/bloc/wallpaper_event.dart';
import 'package:my_wallpaper/bloc/wallpaper_state.dart';

import '../repository/repo.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState>{
  WallpaperRepo repo;
  WallpaperBloc({required this.repo}) : super(WallpaperInitialState()) {
    on<GetTrendingWallpaperEvent>((event, emit) async {
      emit(WallpaperLoadingState());
      var wallpapers = await repo.getTrendingWallpaper(
          perPage: event.perPage, pageNo: event.pageNo);
      emit(WallpaperLoadedState(wallpapers: wallpapers));
    });
    on<GetSearchedWallpaperEvent>((event, emit) async {
      emit(WallpaperLoadingState());
      var wallpapers = await repo.getSearchedWallpaper(
          query: event.query, perPage: event.perPage);
      emit(WallpaperLoadedState(wallpapers: wallpapers));
    });
  }
}