//import 'package:firebase/firebase.dart';

//import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/firestore.dart';
// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';
//import 'package:http/http.dart' as http;
//import 'package:firebase_core/firebase_core.dart';
/*firebase.initializeApp(config);

var db = firebase.firestore();*/
import 'petDetails.dart';
import 'shop.dart';

void main() {
  Firebase.initializeApp();
  runApp(MaterialApp(home: pets(),));
}


class pets extends StatefulWidget {

  @override
  _petsState createState() => _petsState();
}

class _petsState extends State<pets> {

  Widget status_check(bool status){
    if(status==true) {
      return Text("Available", style: TextStyle(
        color: Colors.green,
        fontSize: 25.0,
        fontWeight: FontWeight.w300,
      ),);
    }
    else{
      return Text("Unavailable",style: TextStyle(
        color:Colors.red,
        fontSize: 25.0,
        fontWeight: FontWeight.w300,
      ),);
    }

  }

  Widget buildcard(String name,String age,String breed ,String type, bool status, String img,int Index){
    return Container(
      height: MediaQuery.of(context).size.height*0.4,
      // width: MediaQuery.of(context).size.width*0.3,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: GestureDetector(
          onTap:(){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>details(title: name, Ind: Index,))
            );
          },
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Expanded(flex:2,child: Image.network(img,fit:BoxFit.cover)),
                Expanded(flex:1,child: Container(
                  width: MediaQuery.of(context).size.width,
                  color:Colors.black87,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(name,style: TextStyle(
                              color:Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                            ),),
                          ),
                          Container(child: Text(type,style: TextStyle(
                            color:Colors.grey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                          ),),
                          )
                        ],
                      ),
                      Container(child: status_check(status)
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text("Home"),
        backgroundColor: Colors.grey[800],
        //bottomOpacity: 30.0,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
        ) ,
      ),
      backgroundColor: Colors.black,
      body:Container(
        color:Colors.black,
        height: MediaQuery.of(context).size.height*1.0,
        width: MediaQuery.of(context).size.width*1.0,

        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height*0.3,
          width: MediaQuery.of(context).size.width*0.7,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Pets').snapshots(),
              builder: (context, snapshot){
                /*FirebaseFirestore.instance.collection('Length').doc('home').set(
                    {"length":snapshot.data.docs.length});*/
                if(!snapshot.hasData)
                  return Container(color:Colors.red[300],
                  alignment: Alignment.center,
                  child:Text("Hang on, Loading Content",style: TextStyle(fontSize: 30.0,),),);
                else{

                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                        return  buildcard(
                        snapshot.data.docs[index]['Name'],
                        snapshot.data.docs[index]['Age'].toString(),
                        snapshot.data.docs[index]['Breed'],
                        snapshot.data.docs[index]['Type'],
                        snapshot.data.docs[index]['Status'],
                        snapshot.data.docs[index]['Image'].toString(),
                        index);
                  },

                  );
                }
              },

            ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black87,
          child: Column(
            children: [
             /* Expanded(flex:1,
                child: Container(
                  color: Colors.grey[900],
                ),
              ),*/


              Expanded(flex:1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>pets())
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                        //color: Colors.grey[800],
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black87,
                            Colors.grey[700],
                          ],
                          begin: Alignment.topLeft,
                        )
                      ),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal:15.0,vertical: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home_filled, color: Colors.white,size: 35.0,),
                            Text("Home",style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.w300),),
                          ],
                        )
                    ),
                  )
              ),
              Expanded(flex:1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>products_shop())
                      );
                    },
                    child: Container(
                        alignment: Alignment.center,
                        //color: Colors.grey[800],
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black87,
                                Colors.grey[700],
                              ],
                              begin: Alignment.topLeft,
                            )
                        ),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal:15.0,vertical: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag, color: Colors.white,size: 35.0,),
                            Text("Products for pets",style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.w300),),
                            Text("(Work in Progress)",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w300),),
                          ],
                        )
                    ),
                  )
              ),
              Expanded(flex:1,
                  child: GestureDetector(
                    onTap: (){
                      /*Fluttertoast.showToast(msg: "Work in progress",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          fontSize: 40.0,
                          backgroundColor: Colors.white);*/
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>user_cart())
                      );
                    },
                    child: Container(
                            alignment: Alignment.center,
                            //color: Colors.grey[800],
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black87,
                                    Colors.grey[700],
                                  ],
                                  begin: Alignment.topLeft,
                                )
                            ),
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal:15.0,vertical: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart, color: Colors.white,size: 35.0,),
                                Text("Cart",style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.w300),),
                                Text("(Work in Progress)",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w300),),
                              ],
                            )
                        ),
                  )),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: false,
    );
  }
}

