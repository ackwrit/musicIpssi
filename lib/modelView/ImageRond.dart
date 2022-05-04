import 'package:flutter/material.dart';
import 'package:musicipssi/library/lib.dart';

class ImageRond extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageRondState();
  }

}

class ImageRondState extends State<ImageRond>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: bodyPage(),
    );

  }


  Widget bodyPage(){
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (MonUser.image == null)?const NetworkImage("https://firebasestorage.googleapis.com/v0/b/musicipssi.appspot.com/o/cover.jpg?alt=media&token=2371302d-bac7-415b-86ff-180d60643a5d"):NetworkImage(MonUser.image!),
          fit: BoxFit.fill

        )
      ),

    );
  }

}