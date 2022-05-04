import 'package:flutter/material.dart';
import 'package:musicipssi/fonctions/FirestoreHelper.dart';
import 'package:musicipssi/library/constant.dart';
import 'package:musicipssi/modelView/ImageRond.dart';
import 'package:awesome_icons/awesome_icons.dart';


class myDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myDrawerState();
  }

}

class myDrawerState extends State<myDrawer>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyPage();
  }


  Widget bodyPage(){
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
          color: Colors.amber,
          child: ImageRond(),
        ),

        //Nom
        Row(
          children: [
            Container(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  hintText: MonUser.nom,


                ),
                onChanged: (value){
                  setState(() {
                    MonUser.nom = value;
                  });

                },
              ),

            ),
            IconButton(
                onPressed: (){
                  Map<String,dynamic> map = {
                    "NOM": MonUser.nom
                  };
                  FirestoreHelper().updateUser(MonUser.uid, map);
                },
                icon: const Icon(Icons.edit)
            ),
          ],
        ),


        //prénom
        Row(
          children: [
            Container(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  hintText: MonUser.prenom,


                ),
                onChanged: (value){
                  setState(() {
                    MonUser.prenom = value;
                  });

                },
              ),

            ),
            IconButton(
                onPressed: (){
                  Map<String,dynamic> map = {
                    "PRENOM": MonUser.prenom
                  };
                  FirestoreHelper().updateUser(MonUser.uid, map);
                },
                icon: const Icon(Icons.edit)
            ),
          ],
        ),


        //Pseudo
        Row(
          children: [
            Container(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  hintText: MonUser.pseudo ?? "Entrer votre pseudo",


                ),
                onChanged: (value){
                  setState(() {
                    MonUser.pseudo = value;
                  });

                },
              ),

            ),
            IconButton(
                onPressed: (){
                  Map<String,dynamic> map = {
                    "PSEUDO": MonUser.pseudo
                  };
                  FirestoreHelper().updateUser(MonUser.uid, map);
                },
                icon: const Icon(Icons.edit)
            ),
          ],
        ),

        //Notre adresse mail
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.envelope),
            Text(MonUser.mail)
          ],
        ),

        //Visible ou pas
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.eyeSlash),
            Switch(
                value: MonUser.isConnected,
                onChanged: (value){
                  setState(() {
                    MonUser.isConnected = value;
                  });
                  Map<String,dynamic> map ={
                    "ISCONNECTED": MonUser.isConnected
                  };
                  FirestoreHelper().updateUser(MonUser.uid, map);
                }
            ),

            const Icon(FontAwesomeIcons.eye),
          ],
        ),
      ],
    );
  }

}