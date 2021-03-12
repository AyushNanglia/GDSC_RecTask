import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'package:auto_size_text/auto_size_text.dart';

class details extends StatelessWidget {
  int Ind;
  bool Status;
  String title,Name,Type,Breed,Age,Img;


  details({Key key, @required this.title, @required this.Ind}) : super(key: key);



  /*update()async{
    *//*var docID=FirebaseFirestore.instance.collection('Pets').path;
    print(docID);*//*
    FirebaseFirestore.instance.collection('Pets').
    doc(snapshot.data.docs[Ind]['Name']).update({'Status':false});
  }*/

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text(title),
        backgroundColor: Colors.grey[800],
        //bottomOpacity: 30.0,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
        ) ,
      ),
      backgroundColor: Colors.black,
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Pets').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            return Container(color:Colors.red,);
          else
          { return Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data.docs[Ind]['Image']),
                        minRadius: 120.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(snapshot.data.docs[Ind]['Name'],style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 40.0,
                        fontStyle: FontStyle.italic,
                      ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Breed: ",style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 30.0,
                          ),
                          ),
                            Text(snapshot.data.docs[Ind]['Breed'],style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 30.0,
                            ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Age: ",style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 30.0,
                          ),
                          ),
                            Text(snapshot.data.docs[Ind]['Age'].toString(),style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 30.0,
                            ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: status_check(snapshot.data.docs[Ind]['Status']),
                      ),
                    ],
                  ),
                ),
                Container(
                  width:MediaQuery.of(context).size.width*0.5,

                  child: FlatButton(
                    color: Colors.grey[900],
                    child:AutoSizeText("Change Status",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 30.0,
                    ),
                      maxLines: 1,
                    ), onPressed: (){

                    FirebaseFirestore.instance.collection('Pets').
                    doc(snapshot.data.docs[Ind]['Name']).update({'Status': false});
                    //  print(snapshot.data.docs[Ind]['Status']);
                  },
                  ),
                )
              ],
            ),
          );}
        },

      ) ,
    );
  }

}
