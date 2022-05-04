import 'package:flutter/material.dart';
import 'package:musicipssi/modelView/customPath.dart';

class FondEcran extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FondEcranState();
  }

}

class FondEcranState extends State<FondEcran>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipPath(
        clipper: customPath(),
        child : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/ange-5l.jpg"),
                  fit: BoxFit.fill

              )
          ),
        )
    );
  }

}