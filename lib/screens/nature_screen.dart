import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/bloc/wallpaper_bloc.dart';
import 'package:my_wallpaper/bloc/wallpaper_event.dart';
import 'package:my_wallpaper/bloc/wallpaper_state.dart';
import 'package:my_wallpaper/screens/wallpaper_full_screen.dart';
import 'package:my_wallpaper/ui_helper/ui_helper.dart';

class NatureScreen extends StatefulWidget {
  NatureScreen({super.key});

  @override
  State<NatureScreen> createState() => _NatureScreenState();
}

class _NatureScreenState extends State<NatureScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WallpaperBloc>(context).add(GetSearchedWallpaperEvent(query: 'nature', perPage: '25'));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 45, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nature', style: mTextStyle30()),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.cyanAccent.withOpacity(0.5),
                  ),
                  child: IconButton(onPressed: ()=> Navigator.pop(context),
                      enableFeedback: true, iconSize: 25,
                      icon: Icon(Icons.arrow_back)),
                )
              ],
            ),
            SizedBox(height: size.height*0.01),
            BlocBuilder<WallpaperBloc, WallpaperState>(builder: (context, state) {
              if(state is WallpaperLoadingState){
                return Center(child: CircularProgressIndicator());
              } else if (state is WallpaperLoadedState){
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      mainAxisExtent: size.height*0.35,
                    ),
                    itemCount: state.wallpapers.photos!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            WallpaperFullScreen(imgUrl: state.wallpapers.photos![index].src!.portrait.toString()),)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(state.wallpapers.photos![index].src!.portrait.toString()),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                      );
                    },),
                );
              } else if(state is WallpaperErrorState){
                return Center(child: Text(state.error.toString()),);
              }
              return Container();
            },)
          ],
        ),
      ),
    );
  }
}
