import 'package:flutter/material.dart';
import 'package:musicipssi/library/lib.dart';
import 'package:musicipssi/modelView/fondEcran.dart';

class ajouterMusic extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ajouterMusicState();
  }

}

class ajouterMusicState extends State<ajouterMusic>{
  //Variable
  String title = "";
  String lien = "";
  String? pochette;
  String? artist;
  String? album;
  DateTime sortie = DateTime.now();
  type myCategorie = type.jazz;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Stack(
        children: [
          FondEcran(),
          Center(
            child: bodyPage(),
          )
        ],
      ),

    );

  }

  Widget bodyPage(){
    return Column(
      children: [
        //titre de la musique
        TextField(
          onChanged: (value){
            setState(() {
              title = value;
            });

          },
        ),


        //Envoyer la musique dans la base de donnée


        //Album

        TextField(
          onChanged: (value){
            setState(() {
              artist = value;
            });

          },
        ),



        // artiste

        TextField(
          onChanged: (value){
            setState(() {
              artist = value;
            });

          },
        ),


        //Envoyer la Pochette dans la base de donnée


        //Date de sortie


        //Categorie



        //Boutton


      ],
    );
  }

}