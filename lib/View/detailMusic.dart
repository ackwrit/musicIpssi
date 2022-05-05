import 'dart:async';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:musicipssi/Model/Music.dart';
import 'package:musicipssi/library/lib.dart';
import 'package:musicipssi/modelView/fondEcran.dart';
import 'package:audioplayers/audioplayers.dart';

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
  statut lecture  = statut.stopped;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration positionnement = Duration(seconds: 0);
  late StreamSubscription positionStream;
  late StreamSubscription stateStream;
  Duration dureeTotal = Duration(seconds: 0);
  double volumeSound = 0.5;
  bool isPlaying = false;


  //Fonction
  configurationPlayer(){
    audioPlayer.setUrl(widget.musique.lienMusic);
    positionStream = audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        positionnement = event;
      });
      audioPlayer.onDurationChanged.listen((event) {
        setState(() {
          print("durée total $event");
          dureeTotal = event;
        });
      });
      stateStream = audioPlayer.onPlayerStateChanged.listen((event) {
          if(event == statut.playing){
            setState(() async {
              dureeTotal = audioPlayer.getDuration() as Duration;
              lecture = statut.playing;
            });
          }
          else if(event == statut.stopped){
            setState(() {
              lecture = statut.stopped;
            });

          }
      }
      ,onError:(message){
         print("erreur : $message");
         setState(() {
           lecture = statut.stopped;
           positionnement = const Duration(seconds: 0);
           dureeTotal  = const Duration(seconds : 0);
         });
          }
      );



    });
  }





  //play
  Future play() async {
    await audioPlayer.play(widget.musique.lienMusic,position: positionnement,volume: volumeSound);
  }


  //pause
  Future pause() async{
    await audioPlayer.pause();

  }


  //avance rapide


  //Retour en arrière


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configurationPlayer();
  }

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
          width: 450,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //fast_forward
            IconButton(
                onPressed: (){

                },
                icon: const Icon(FontAwesomeIcons.backward),
            ),

            //
            (lecture == statut.stopped)? IconButton(
              onPressed: (){
                setState(() {
                  lecture = statut.paused;
                  play();
                });

              },
              icon: const Icon(FontAwesomeIcons.play,size: 40,),
            ): IconButton(
              onPressed: (){
                setState(() {
                  lecture = statut.stopped;
                  pause();
                });

              },
              icon: const Icon(FontAwesomeIcons.pause,size: 40,),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(positionnement.toString()),

            Text(dureeTotal.toString())
          ],
        ),

        Slider(
            min: 0.0,
            max: dureeTotal.inSeconds.toDouble(),
            value: positionnement.inSeconds.toDouble(),
            onChanged: (newValue){
              setState(() {
                Duration time = Duration(seconds: newValue.toInt());
                positionnement = time;

              });
            }
        ),

      ],
    );
  }

}

