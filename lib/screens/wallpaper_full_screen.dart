import 'package:flutter/material.dart';
import 'package:my_wallpaper/ui_helper/ui_helper.dart';
import 'package:wallpaper/wallpaper.dart';

class WallpaperFullScreen extends StatelessWidget {
  String imgUrl;
  WallpaperFullScreen({required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image.network(imgUrl, fit: BoxFit.fitHeight),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
                    width: size.width*0.14, height: size.width*0.14,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.arrow_back_rounded, color: Colors.white,),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setWallpaper(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
                    width: size.width*0.14, height: size.width*0.14,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.system_update, color: Colors.white,),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
  void setWallpaper(BuildContext context){
    var process = Wallpaper.imageDownloadProgress(imgUrl);
    var size = MediaQuery.of(context).size;

    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: size.height*0.25,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Column(
          children: [
            Text('Set Wallpaper', style: mTextStyle16(color: Colors.red),),
            Divider(indent: 20, endIndent: 20,),
            InkWell(
              onTap: (){
                process.listen((event) {},
                    onDone: () async{
                     String check = await Wallpaper.homeScreen(
                        width: size.width,
                        height: size.height,
                        options: RequestSizeOptions.RESIZE_FIT,
                      );
                     print(check);
                     ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('Wallpaper Set'),)
                     );
                     Navigator.pop(context);
                    });
              },
                child: Text('HOME SCREEN', style: mTextStyle16(fontWeight: FontWeight.w400),)),
            Divider(indent: 20, endIndent: 20,),
            InkWell(
              onTap: (){
                process.listen((event) {},
                    onDone: () async{
                      await Wallpaper.lockScreen(
                        width: size.width,
                        height: size.height,
                        options: RequestSizeOptions.RESIZE_FIT,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Wallpaper Set'),)
                      );
                      Navigator.pop(context);
                    });
              },
                child: Text('LOCK SCREEN', style: mTextStyle16(fontWeight: FontWeight.w400),)),
            Divider(indent: 20, endIndent: 20,),
            InkWell(
              onTap: (){
                process.listen((event) {},
                    onDone: () async{
                      await Wallpaper.bothScreen(
                        width: size.width,
                        height: size.height,
                        options: RequestSizeOptions.RESIZE_FIT,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Wallpaper Set'),)
                      );
                      Navigator.pop(context);
                    });
              },
                child: Text('BOTH SCREENS', style: mTextStyle16(fontWeight: FontWeight.w400),)),
          ],
        ),
      );
    },);
  }
}
