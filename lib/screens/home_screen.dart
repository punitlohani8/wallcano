import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/Services/wallpaper_model.dart';
import 'package:my_wallpaper/app_widgets/categories_container.dart';
import 'package:my_wallpaper/bloc/wallpaper_bloc.dart';
import 'package:my_wallpaper/bloc/wallpaper_event.dart';
import 'package:my_wallpaper/bloc/wallpaper_state.dart';
import 'package:my_wallpaper/repository/repo.dart';
import 'package:my_wallpaper/screens/abstract_screen.dart';
import 'package:my_wallpaper/screens/animals_screen.dart';
import 'package:my_wallpaper/screens/nature_screen.dart';
import 'package:my_wallpaper/screens/search_screen.dart';
import 'package:my_wallpaper/screens/space_screen.dart';
import 'package:my_wallpaper/screens/wallpaper_full_screen.dart';
import 'package:my_wallpaper/ui_helper/ui_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late WallpaperModel wallpapers;
  var searchController = TextEditingController();
  int page = 1;
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WallpaperBloc>(context).add(GetTrendingWallpaperEvent(pageNo: '1', perPage: '25'));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
                  child: TextFormField(
                    controller: searchController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please enter your keyword first';
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Find Wallpaper',
                      contentPadding: EdgeInsets.all(15),
                      suffixIcon: TextButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(query: searchController.text.toString(),),));
                          }
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Latest Wallpapers', style: mTextStyle16(),),
                          InkWell(
                            onTap: (){
                              BlocProvider.of<WallpaperBloc>(context).add(GetTrendingWallpaperEvent(perPage: '25', pageNo: '${page++}'));
                            },
                              child: Text('Load More  ', style: mTextStyle12(color: Colors.cyan, fontWeight: FontWeight.w500),)),
                        ],
                      ),
                      SizedBox(
                        height: height*0.42,
                        child: BlocBuilder<WallpaperBloc, WallpaperState>(
                          builder: (context, state) {
                            if(state is WallpaperLoadingState){
                              return Center(child: CircularProgressIndicator(),);
                            } else if(state is WallpaperLoadedState){
                              wallpapers = state.wallpapers;
                                return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                  itemCount: wallpapers.photos!.length,
                                  itemBuilder: (context, index) {
                                    var image = wallpapers.photos![index].src!.portrait;
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => WallpaperFullScreen(imgUrl: image.toString()),));
                                      },
                                      child: Container(
                                        width: width*0.5,
                                        margin: EdgeInsets.only(top: 10, right: 16),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: NetworkImage(image.toString()),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                    );
                                  },);
                            } if(state is WallpaperErrorState) {
                              return Center(child: Text(state.error.toString()),);
                            } else{
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Categories', style: mTextStyle16(),),
                      SizedBox(height: height*0.01,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => AbstractScreen(),)),
                                child: CategoriesContainer(
                                    assetImg: 'assets/images/abstract.jpg', text: 'Abstract'),
                              ),
                              InkWell(
                                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => NatureScreen(),)),
                                child: CategoriesContainer(
                                    assetImg: 'assets/images/nature.jpg', text: 'Nature'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SpaceScreen(),)),
                                child: CategoriesContainer(
                                    assetImg: 'assets/images/space.jpg', text: 'Space'),
                              ),
                              InkWell(
                                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalsScreen(),)),
                                child: CategoriesContainer(
                                    assetImg: 'assets/images/animal.jpg', text: 'Animals'),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
