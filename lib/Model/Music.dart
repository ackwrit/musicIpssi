
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musicipssi/library/lib.dart';

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
    String value = map["CATEGORY"];
    category = conversion(value);
    artist = map["ARTIST"];
    Timestamp timestamp = map["SORTIE"];
    sortie = timestamp.toDate();
    pochette = map["POCHETTE"];
    album = map["ALBUM"];
  }


  //Méthode

  type conversion(String str){
    switch(str){
      case "type.rap" : return type.rap;
      case "type.soul" : return type.soul;
      case "type.techno" : return type.techno;
      case "type.rock" : return type.rock;
      case "type.zouk" : return type.zouk;
      case "type.reggae" : return type.reggae;
      case "type.rnb" : return type.rnb;
      case "type.jazz" :return type.jazz;
      default: return type.rap;
    }
  }
}




