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
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (MonUser.image == null)?NetworkImage("https://firebasestorage.googleapis.com/v0/b/musicipssi.appspot.com/o/noPicture.jpeg?alt=media&token=2c929236-5eca-4f9b-b713-4988ef2a91d2"):NetworkImage(MonUser.image!),
          fit: BoxFit.fill
        )
      ),

    );
  }

}