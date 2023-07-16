import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as httpClint;
import 'package:my_wallpaper/Services/api_exceptions.dart';
import 'package:my_wallpaper/Services/wallpaper_model.dart';

class APIService{
  String baseUrl = "https://api.pexels.com/v1/";
  String apiKey = 'bcqoBJZk844aQOTWLC7Q0qySRIzewyz1NVLIhcx3fwAcy8EssqNZFOe2';

  Future<dynamic> getWallpaper({required String myUrl, Map<String, String>? headers}) async{
    try{
      var res = await httpClint.get(Uri.parse('$baseUrl$myUrl'), headers: headers ?? {
        'Authorization' : apiKey,
      });
      return checkResponse(res);
    } on SocketException{
      throw FetchDataException('No Internet Connection');
    }

  }
  dynamic checkResponse(httpClint.Response res){
    switch(res.statusCode){
      case 200:
        var jsonResponse = json.decode(res.body.toString());
        return jsonResponse;
      case 400:
        throw BadRequestException(res.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(res.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with the server with StatusCode : ${res.statusCode.toString()}'
        );
    }
  }
}