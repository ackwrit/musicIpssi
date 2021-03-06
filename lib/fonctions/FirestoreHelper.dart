
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:musicipssi/Model/Profil.dart';

class FirestoreHelper {
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final fireUser = FirebaseFirestore.instance.collection("Utilisateurs");
  final fireMusic = FirebaseFirestore.instance.collection("Musiques");



      //Méthodes


      //Inscription un utilisateur


    Future <Profil> register(String prenom , String nom , String mail , String password) async {
      UserCredential resultat = await auth.createUserWithEmailAndPassword(email: mail, password: password);
      String uid = resultat.user!.uid;
      Map<String,dynamic> map = {
          "PRENOM":prenom,
          "NOM":nom,
          "MAIL": mail,
          "ISINSCRIPTION":DateTime.now(),
          "ISCONNECTED": true,
        };
      addUser(uid,map);
      return getProfil(uid);
    }







      //Connexion d'un utlisateur
      Future <Profil> connect(String mail , String password) async {
        UserCredential resultat = await auth.signInWithEmailAndPassword(email: mail, password: password);
        String uid = resultat.user!.uid;
        return getProfil(uid);

      }

      //Fonction a pour de récupérer l'id de l'utisateur qui s'est connecté
      String getCurrentUserId(){
       return  auth.currentUser!.uid;
      }


      //Fonction a pour de construire une classe profil
      Future <Profil> getProfil(String uid) async{
        DocumentSnapshot snapshot = await fireUser.doc(uid).get();
        return Profil(snapshot);
      }



      // ajouter un utilisateur dans la base de donnée
    addUser(String uid , Map<String,dynamic>map){
      fireUser.doc(uid).set(map);
    }



    // mise à jour d'un utilisateur dans la base de donnée
    updateUser(String uid,Map<String,dynamic> map){
      fireUser.doc(uid).update(map);
    }


      // ajouter une musique dans la base de donnée
    addMusic(String uid ,Map<String,dynamic> map){
      fireMusic.doc(uid).set(map);
    }


      //Stockage une fichier
      Future<String> stockageFile(String nameFile,Uint8List datas, bool imageSelected) async {
        late String pathFile;
        late TaskSnapshot snap;
        if(imageSelected){
           snap = await storage.ref("pictures/$nameFile").putData(datas);
        }
        else
          {
           snap = await storage.ref("songs/$nameFile").putData(datas);
          }
        pathFile = await snap.ref.getDownloadURL();
        return pathFile;
      }







}