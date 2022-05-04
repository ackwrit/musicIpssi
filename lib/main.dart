

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:musicipssi/Controller/Inscription.dart';
import 'package:musicipssi/Controller/connexion.dart';
import 'package:musicipssi/modelView/customPath.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if ((defaultTargetPlatform == TargetPlatform.iOS) || (defaultTargetPlatform == TargetPlatform.android)){
    await Firebase.initializeApp();
  }
  else
    {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyB3zphvnqXHBpu6HucH4g39kMqvM3GFhwI",
              appId: "1:94258907:web:441900fe7d14ea5fc1aefe",
              messagingSenderId: "94258907",
              projectId: "musicipssi",
              storageBucket: "musicipssi.appspot.com"
          )
      );
    }



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Variable
  bool selected = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [
          fondEcran(),
          bodyPage(),


        ],
      ),

  // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget bodyPage(){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Inscription"),
            Switch(
                value: selected,
                onChanged: (value){
                  setState(() {
                    selected = value;
                  });
                }
            ),
            const Text("Connexion"),
          ],

        ),
        (selected)?Connexion():Inscription()


      ],
    );
  }


  Widget fondEcran(){
    return ClipPath(
      clipper: customPath(),
      child : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ange-5l.jpg"),
            fit: BoxFit.fill

          )
        ),
      )
    );
  }
}
