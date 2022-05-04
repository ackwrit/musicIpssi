
import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  //Attributs
  late String _uid;
  late String _nameMusic;
  late String _lienMusic;
  late type category;
  String? artist;
  late DateTime sortie;
  String? pochette;
  String? album;

  String get uid {
    return _uid;
  }



  String get nameMusic {
    return _nameMusic;
  }

  set nameMusic(String newValue){
    _nameMusic = newValue;
  }

  String get lienMusic {
      return _lienMusic;
  }



  //Constructeur
  Music(DocumentSnapshot snapshot){
    _uid = snapshot.id;
    Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
    _nameMusic = map["NAMEMUSIC"];
    _lienMusic = map ["LIENMUSIC"];
    category = map["CATEGORY"];
    artist = map["ARTIST"];
    Timestamp timestamp = map["SORTIE"];
    sortie = timestamp.toDate();
    pochette = map["POCHETTE"];
    album = map["ALBUM"];
  }


  //Méthode
}


enum type {rap,soul,techno,rock,zouk,reggae,rnb,jazz}