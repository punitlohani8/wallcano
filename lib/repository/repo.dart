import 'package:my_wallpaper/Services/api_services.dart';
import 'package:my_wallpaper/Services/wallpaper_model.dart';

class WallpaperRepo{

  Future<WallpaperModel> getTrendingWallpaper({String? perPage, String? pageNo}) async{
    var url = 'curated?per_page=${perPage ?? 25}&page=${pageNo ?? 1}';
    var jsonRes = await APIService().getWallpaper(myUrl: url);
    return WallpaperModel.fromJson(jsonRes);
  }
  Future<WallpaperModel> getSearchedWallpaper({String? query, String? perPage}) async{
    var url = 'search?query=$query&per_page=${perPage ?? 25}';
    var jsonRes = await APIService().getWallpaper(myUrl: url);
    return WallpaperModel.fromJson(jsonRes);
  }
}