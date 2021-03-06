import 'package:flutter/material.dart';
import 'package:musicipssi/View/DashBoard.dart';
import 'package:musicipssi/fonctions/FirestoreHelper.dart';
import 'package:musicipssi/library/constant.dart';

class Connexion extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConnexionState();
  }

}

class ConnexionState extends State<Connexion>{
  //Variable
  String mail ="";
  String password ="";




  //Fonctions

  Dialogue(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: const Text("Erreur"),
            content: const Text("Votre adresse mail/ ou votre mot a été mal saisie"),
            actions: [

              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Ok")
              ),
            ],
          );
        }
    );
  }



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
              password = value;
            });
          },
        ),
        SizedBox(height: 10,),


        //Bouton pour la connexion
        ElevatedButton(
            onPressed: (){
              // Se connecter
              FirestoreHelper().connect(mail, password).then((value){
                setState(() {
                  MonUser = value;
                });
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return DashBoard();
                    }
                ));


              }).catchError((error){
                Dialogue();

              });
            },
            child: Text("Connexion")
        )
      ],

    );
  }

}