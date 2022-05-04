import 'package:flutter/material.dart';

class Inscription extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InscriptionState();
  }

}

class InscriptionState extends State<Inscription>{
  String prenom = "";
  String nom = "";
  String mail = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }



  Widget bodyPage(){
    return Column(
      children: [
       TextField(
         decoration: const InputDecoration(
           hintText: "Entrer votre prénom"
         ),
        onChanged: (value){
           setState(() {
             prenom = value;
           });
        },
       ),
        TextField(
          decoration: const InputDecoration(
              hintText: "Entrer votre nom"
          ),
          onChanged: (value){
            setState(() {
              nom = value;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: "Entrer votre mail"
          ),
          onChanged: (value){
            setState(() {
              mail = value;
            });
          },
        ),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Entrer votre mot de passe"
          ),
          onChanged: (value){
            setState(() {
              password = value;
            });
          },
        ),


        ElevatedButton(
            onPressed: (){
              // s'inscrire
            },
            child: Text("Inscription")
        )
      ],
    );
  }

}