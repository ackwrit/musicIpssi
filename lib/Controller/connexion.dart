import 'package:flutter/material.dart';

class Connexion extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConnexionState();
  }

}

class ConnexionState extends State<Connexion>{
  String mail ="";
  String password ="";
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
              mail = value;
            });
          },
        ),


        //Bouton pour la connexion
        ElevatedButton(
            onPressed: (){
              // Se connecter
            },
            child: Text("Connexion")
        )
      ],

    );
  }

}