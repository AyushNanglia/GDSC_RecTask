import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';



class cartSum extends StatelessWidget {
  List ar;
  int sum=0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        int doc_length=snapshot.data.docs.length;
        for(int i=0; i<doc_length; i++){
          ar[i]=snapshot.data.docs[i]['Price'];
        }
        for(int j=0; j<doc_length; j++){
          sum+=ar[j];
        }
        return Container(
          child: Text("$sum",style: TextStyle(fontSize: 30.0,color: Colors.white),),
        );
      },
    );
  }
}
