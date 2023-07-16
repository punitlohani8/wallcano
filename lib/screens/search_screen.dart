import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/bloc/wallpaper_bloc.dart';
import 'package:my_wallpaper/bloc/wallpaper_event.dart';
import 'package:my_wallpaper/screens/wallpaper_full_screen.dart';

import '../bloc/wallpaper_state.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    query = widget.query;
    searchController..text = query;
    BlocProvider.of<WallpaperBloc>(context).add(GetSearchedWallpaperEvent(query: query, perPage: '25'));
  }
  late String query;
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 15),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Find Wallpaper',
                    contentPadding: EdgeInsets.all(15),
                    suffixIcon: TextButton(
                      onPressed: (){
                        BlocProvider.of<WallpaperBloc>(context).add(GetSearchedWallpaperEvent(query: searchController.text.toString(), perPage: '25'));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.cyanAccent.withOpacity(0.1)
                      ),
                      child: Icon(Icons.search, color: Colors.cyan,),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
              ),
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
      ),
    );
  }
}
