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
  Duration dureeTriche = Duration(seconds:800);
  double volumeSound = 0.5;
  bool isPlaying = false;


  //Fonction
  configurationPlayer(){
    //Cette instruction définit le morceau qui sera lu
    audioPlayer.setUrl(widget.musique.lienMusic);
    //Cette instruction définit lors de la lecture , la variable positionnement récupéra la durée ou la lecture est situé
    positionStream = audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        positionnement = event;
      });
    });
    //Affection du la durée totale lors de la lecture
      audioPlayer.onDurationChanged.listen((event) {
        setState(() {
          print("durée total $event");
          dureeTotal = event;
        });
      });

      //affectation de la durrée lors du changement de statut et affectatio des différents status lors du changement de l'état de lecture
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




  }





  //play
  Future play() async {
    await audioPlayer.play(widget.musique.lienMusic,position: positionnement,volume: volumeSound);
    if(positionnement == dureeTotal){
      setState(() {
        lecture = statut.stopped;
        positionnement = const Duration(seconds: 0);
      });

    }
  }


  //pause
  Future pause() async{
    await audioPlayer.pause();


  }

  Future stop() async {
    await audioPlayer.stop();
  }


  //avance rapide
  forward(){
    if(positionnement.inSeconds +10 <= dureeTotal.inSeconds){
      setState(() {
        pause();
        positionnement = Duration(seconds: positionnement.inSeconds.toInt() +10);
        play();
      });
    }
    else
      {
        setState(() {
          stop();
          lecture = statut.stopped;
          positionnement = const Duration(seconds: 0);
        });
      }

  }




  //Retour en arrière
  rewind(){
    if(positionnement >= Duration(seconds : 10)){
      setState(() {
        pause();
        positionnement = Duration(seconds: positionnement.inSeconds.toInt() - 10);
        play();

      });

    }
    else
    {
      setState(() {
        pause();
        positionnement = Duration(seconds: 0);
        play();

      });
    }
  }





  //la fonction init est la prmière fonction a être appelé lors de la création de la page
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
        leading: IconButton(
          onPressed: (){
            stop();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          FondEcran(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child:Center(
              child:  bodyPage(),
            ) ,

          )
        ],
      ),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        //Pochette
        Hero(
          tag: widget.musique.uid,
          child:  AnimatedContainer(
            duration: Duration(seconds: 2),
            height: (lecture == statut.stopped)?150:300,
            width: (lecture == statut.stopped)?250:450,
            curve: Curves.elasticOut,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: (widget.musique.pochette == null)?NetworkImage("https://firebasestorage.googleapis.com/v0/b/musicipssi.appspot.com/o/cover.jpg?alt=media&token=2371302d-bac7-415b-86ff-180d60643a5d"):NetworkImage(widget.musique.pochette!)
                )
            ),
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
            //Icon retour en arrière
            IconButton(
                onPressed: (){
                  rewind();

                },
                icon: const Icon(FontAwesomeIcons.backward),
            ),

            // Icon lecture ou pause suivant la état de lecture l'icon change avec le ternaire
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


            //Icon avaace rapide
            IconButton(
              onPressed: (){
                  forward();
              },
              icon: const Icon(FontAwesomeIcons.forward),
            ),

          ],
        ),



        //Slider pour le lecteur
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(positionnement.toString().substring(2,7)),

            Text(dureeTotal.toString().substring(2,7))
          ],
        ),

        Slider(
            min: 0.0,
            max: dureeTotal.inSeconds.toDouble(),
            value: positionnement.inSeconds.toDouble(),
            onChanged: (newValue){
              setState(() {
                //lorsque l'utilisateur change la valeur du Slider
                //la  lecture se repositionne à la nouvelle position de lecture
                Duration time = Duration(seconds: newValue.toInt());
                positionnement = time;
                audioPlayer.seek(positionnement);


              });
            }
        ),

      ],
    );
  }

}

