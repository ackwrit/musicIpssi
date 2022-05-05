import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:musicipssi/Model/Music.dart';
import 'package:musicipssi/modelView/fondEcran.dart';

class  detailMusic extends StatefulWidget{
  Music musique;
  detailMusic({required Music this.musique});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailMusicState();
  }


}

class detailMusicState extends State<detailMusic>{
  //variable
  double positionnement = 0;
  bool isPlaying = false;


  //
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          FondEcran(),
          Center(
            child:  bodyPage(),
          )
        ],
      ),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        //Pochette
        Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (widget.musique.pochette == null)?NetworkImage("https://firebasestorage.googleapis.com/v0/b/musicipssi.appspot.com/o/cover.jpg?alt=media&token=2371302d-bac7-415b-86ff-180d60643a5d"):NetworkImage(widget.musique.pochette!)
            )
          ),
        ),


        // Titre de la musique
        Text(widget.musique.nameMusic,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),


        //artist
        Text(widget.musique.artist!,style: const TextStyle(fontSize: 20),),

        // album
        Text(widget.musique.album!,style: const TextStyle(fontSize: 20),),


        //catégorie

        Text(widget.musique.category.toString().substring(5),style: const TextStyle(fontSize: 20,fontStyle: FontStyle.italic),),


        //Icon de lecture, de pause,avance rapide, retour en arrière
        Row(
          children: [
            //fast_forward
            IconButton(
                onPressed: (){

                },
                icon: const Icon(FontAwesomeIcons.backward),
            ),

            //
            (isPlaying)? IconButton(
              onPressed: (){

              },
              icon: const Icon(FontAwesomeIcons.pause),
            ): IconButton(
              onPressed: (){

              },
              icon: const Icon(FontAwesomeIcons.play),
            ),



            IconButton(
              onPressed: (){

              },
              icon: const Icon(FontAwesomeIcons.forward),
            ),





            //fast_rewind
          ],
        ),



        //Slider pour le lecteur
        Row(
          children: [
            Text("temps de début"),
            Slider(
                value: positionnement,
                onChanged: (newValue){
                  setState(() {
                    positionnement = newValue;
                  });
                }
            ),
            Text("Temps fin")
          ],
        ),

      ],
    );
  }

}