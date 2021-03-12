import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class products_shop extends StatefulWidget {
  @override
  _products_shopState createState() => _products_shopState();
}

class _products_shopState extends State<products_shop> {

   Widget buildProdCard(String prodName, int prodPrice){

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[800],
      ),
      height: MediaQuery.of(context).size.height*0.1,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(prodName, style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 25.0,
          ),),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Rs.$prodPrice",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
              ),),
              Text("Per Unit",style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 15.0,
              ),),
            ],
          )
        ],
      ),
    );


  }
  //bool flag=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text("Shop"),
        backgroundColor: Colors.grey[800],
        //bottomOpacity: 30.0,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
        ) ,
      ),
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Container(
          color: Colors.black,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Products').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              Widget product_card(String prodName, int prodPrice, int Ind){
                return FlatButton(
                    onPressed:(){
                      var doc_id=snapshot.data.docs[Ind]['Name'];
                      var price=snapshot.data.docs[Ind]['Price'];

                      FirebaseFirestore.instance.collection('Cart').doc('$doc_id').set(
                          {"Name": doc_id,"Price":price});
                    },
                    child: buildProdCard(prodName, prodPrice),
                  splashColor: Colors.grey[300],
                );
              }

              if(!snapshot.hasData)
                return Text("Hang on, Loading Content");
              else
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (
                      BuildContext context, int index) {
                    return product_card(snapshot.data.docs[index]['Name'], snapshot.data.docs[index]['Price'],index);
                  },
                )
                ;
              },

          )
        ),
      ),
    );
  }
}
/*GestureDetector(
                  onTap: (){
                 //   bool flag=true;
                    var doc_id=snapshot.data.docs[Ind]['Name'];
                    var price=snapshot.data.docs[Ind]['Price'];

                    FirebaseFirestore.instance.collection('Cart').doc('$doc_id').set(
                        {"Name": doc_id,"Price":price});
                    *//*FirebaseFirestore.instance.collection('Products').doc('$doc_id').set(
                        {"cart":false});*//*

                   // _showMyDialog(prodName,prodPrice,Ind);
                   *//* Fluttertoast.showToast(msg: "Work in progress",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.white);*//*
                  },
                  child:buildProdCard(prodName, prodPrice)
                );*/    ///Gesture Detector