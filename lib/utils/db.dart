import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/models/user.dart';

class db{
  static final firestore= Firestore.instance;
  static  Future<DocumentReference>addTodo(user){
    CollectionReference collectionReference=firestore.collection("todo");
    Future<DocumentReference> future=collectionReference.add(user.convertToMap());
    return future;

  }
  static  Stream<QuerySnapshot>  showData(){
    CollectionReference collectionReference=firestore.collection("todo");
    return firestore.collection("todo").snapshots();

  }
  static Future<DocumentReference> deleteData(List<String > ids ){
    ids.forEach((id) {
      firestore.collection("todo").document(id).delete();
    });



  }
  static Future<void> updateData(documentID, user us) {
    CollectionReference collectionReference = firestore.collection("todo");
   Future<void> future= collectionReference.document(documentID).updateData(us.convertToMap());
   return future;
  }
  static Future<QuerySnapshot> getAllRecords(){
    CollectionReference collectionReference=firestore.collection("todo");
    return firestore.collection("todo").getDocuments();
  }
}