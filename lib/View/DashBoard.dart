import 'package:awesome_icons/awesome_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicipssi/Model/Music.dart';
import 'package:musicipssi/View/ajouterMusic.dart';
import 'package:musicipssi/View/detailMusic.dart';
import 'package:musicipssi/fonctions/FirestoreHelper.dart';
import 'package:musicipssi/modelView/fondEcran.dart';
import 'package:musicipssi/modelView/myDrawer.dart';

class DashBoard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashBoardState();
  }

}

class DashBoardState extends State<DashBoard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //Burger
      drawer: Container(
        child:  myDrawer(),
        width: MediaQuery.of(context).size.width/3,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.amber,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))
        ),

      ),

      ////
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return ajouterMusic();

                    }
                ));
              },
              icon: const Icon(FontAwesomeIcons.plusCircle,color: Colors.amber,)
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      //extendBody: true,

      body: Stack(
        children: [

          FondEcran(),
          Center(
            child: bodyPage(),
          ),


        ],
      ),


    );


  }
  Widget bodyPage(){
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fireMusic.snapshots(),
        builder: (context,snapshot){

          if(snapshot.data?.docs == null){

            return const Center(
              child: Text("Pas de musique existante ...."),
            );
          }
          else
            {
              List documents = snapshot.data!.docs;
               return GridView.builder(
                  itemCount: documents.length,
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                   itemBuilder: (context,index){
                     Music morceau = Music(documents[index]);
                     return InkWell(
                       child: Container(

                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             image: DecorationImage(
                                 image: (morceau.pochette == null)?const NetworkImage("https://firebasestorage.googleapis.com/v0/b/musicipssi.appspot.com/o/cover.jpg?alt=media&token=2371302d-bac7-415b-86ff-180d60643a5d"):NetworkImage(morceau.pochette!),
                                 fit: BoxFit.fill
                             )
                         ),
                       ),
                       onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return detailMusic(musique: morceau,);
                              }
                          ));
                       },

                     );

                   }
               );
            }
        }
    );
  }

}