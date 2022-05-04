import 'package:flutter/material.dart';
import 'package:musicipssi/modelView/fondEcran.dart';
import 'package:musicipssi/modelView/myDrawer.dart';

class DashBoard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashBoardState();
  }

}

class DashBoardState extends State<DashBoard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //Burger
      drawer: Container(
        child:  myDrawer(),
        width: MediaQuery.of(context).size.width/3,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))
        ),

      ),

      ////
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      //extendBody: true,

      body: Stack(
        children: [

          FondEcran(),
          Center(
            child: bodyPage(),
          ),


        ],
      ),


    );


  }
  Widget bodyPage(){
    return const Text("Je suis dans la Dahsboard");
  }

}