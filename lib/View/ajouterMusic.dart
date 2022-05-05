import 'dart:typed_data';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:musicipssi/fonctions/FirestoreHelper.dart';
import 'package:musicipssi/library/lib.dart';
import 'package:musicipssi/modelView/fondEcran.dart';
import 'package:random_string/random_string.dart';

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
  bool isImageselected = false;
  Uint8List? bytesData;
  String? nameFichier;



  //Fonctions
  recuperFichier() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: (isImageselected)?FileType.image:FileType.audio
    );
    if(result != null){
      setState(() {
        nameFichier = result.files.first.name;
        bytesData = result.files.first.bytes;
      });
      if(isImageselected){
        boiteDilaogue();
      }
      else {
        // Directement la son
        FirestoreHelper().stockageFile(nameFichier!, bytesData!, isImageselected).then((value) {
          setState(() {
            lien = value;
          });
        });

      }

    }
  }


  boiteDilaogue(){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text("Souhaitez enregistrer cette image ?"),
              content: Image.memory(bytesData!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      FirestoreHelper().stockageFile(nameFichier!, bytesData!, isImageselected).then((value){
                        setState(() {
                          pochette = value;
                        });
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Valider")
                )

              ],
            );
          }
      );
  }
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
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10)
          ),
            onPressed: (){
              //File picker
              setState(() {
                isImageselected = false;
              });
              recuperFichier();
            },
            icon: const Icon(FontAwesomeIcons.music),
            label: const Text("Ajouter la musique")
        ),


        //Album

        TextField(
          onChanged: (value){
            setState(() {
              album = value;
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
        ElevatedButton.icon(

            style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10)
            ),
            onPressed: (){
              //File picker
              setState(() {
                isImageselected = true;
              });
              recuperFichier();
              
            },
            icon: const Icon(FontAwesomeIcons.images),
            label: const Text("Ajouter la pochette")
        ),


        //Date de sortie


        //Categorie
        DropdownButtonFormField(
           decoration: InputDecoration(
             fillColor: Colors.white,
             filled: true,
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
             )
           ),
            value: myCategorie,
            items: type.values.map((value){
              return DropdownMenuItem(
                value: value,
                  child: Text(value.toString().substring(5))
              );
            }).toList(), 
            onChanged: (type? newValue){
             setState(() {
               myCategorie = newValue!;
             });

            }
        ),




        //Boutton
          ElevatedButton(
              onPressed: (){
                Map<String,dynamic> map ={
                  "NAMEMUSIC": title,
                  "LIENMUSIC": lien,
                  "CATEGORY": myCategorie.toString(),
                  "SORTIE": DateTime.now(),
                  "ARTIST": artist,
                  "POCHETTE": pochette,
                  "ALBUM": album,
                };
                String uid = randomAlphaNumeric(20);
                FirestoreHelper().addMusic(uid, map);
                Navigator.pop(context);
              },
              child: Text("Enregistrer")
          ),


      ],
    );
  }

}