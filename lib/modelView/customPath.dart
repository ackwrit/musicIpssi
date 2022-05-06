import 'package:flutter/material.dart';



//Cette classe à pour but de créer un chemin
class customPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0, size.height/3);


    path.lineTo(size.width, 0);


    path.close();


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}