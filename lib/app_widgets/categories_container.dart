import 'package:flutter/material.dart';
import 'package:my_wallpaper/ui_helper/ui_helper.dart';

class CategoriesContainer extends StatelessWidget {
  String assetImg;
  String text;
  CategoriesContainer({super.key, required this.assetImg, required this.text});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.44, height: size.height*0.13,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(assetImg),
          fit: BoxFit.cover
        )
      ),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15
              )
            ]
        ),
          child: Text(text, style: mTextStyle16(color: Colors.white),)),
    );
  }
}
