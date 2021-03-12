import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class user_cart extends StatefulWidget {
  @override
  _user_cartState createState() => _user_cartState();
}




class _user_cartState extends State<user_cart> {
  var total=0;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text("Cart"),
        backgroundColor: Colors.grey[800],
        //bottomOpacity: 30.0,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
        ) ,
      ),
      backgroundColor: Colors.black,
      body: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                Widget build_cartCard(String Name,int Index,int Price,int index){
                  return FlatButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('Cart').doc('$Name').delete();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex:2,child:
                              Container(
                                //color: Colors.blueGrey,
                                  child: AutoSizeText(Name,maxLines:1,style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.w300),))),
                              Expanded(flex:1,child:
                              Container(
                                //color: Colors.grey,
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText("$Price x1",maxLines:1,style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.w300),))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if(!snapshot.hasData)
                  return Text("Hang on, Loading Content");
                else
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      /*FirebaseFirestore.instance.collection('Length').doc('cart').set(
                          {"length":snapshot.data.docs.length});*/
                      /*for(int i=0; i<=snapshot.data.docs.length; i++)
                        {
                          total=total+snapshot.data.docs[index]['Price'];
                        }*/
                      //if(snapshot.data.docs[index]['cart']==true)
                      return build_cartCard(snapshot.data.docs[index]['Name'], index,snapshot.data.docs[index]['Price'],index);

                    },
                  );
              },

            ),
          )


    );
  }
}
