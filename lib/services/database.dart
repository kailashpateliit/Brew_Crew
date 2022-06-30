import 'package:brew_crew/model/brew_model.dart';
import 'package:brew_crew/model/user_model.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService{

  String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  //updating the database
  Future updateUserData(String sugar,String name,int strength)async{
      return await brewCollection.doc(uid).set({
        'sugar': sugar,
        'name': name,
        'strength': strength,
      });
  }

  // brew list from snapshot
  List<BrewModel> _brewListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc){
      return BrewModel(
          sugar: doc.get('sugar')?? '0',
          strength: doc.get('strength')?? 0,
          name: doc.get('name')?? '');
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot){
    return UserData(
        uid: uid!,
        name: documentSnapshot.get('name'),
        sugar: documentSnapshot.get('sugars'),
        strength: documentSnapshot.get('strength')
    );
  }

  // get the brew stream from firebase
  Stream<List<BrewModel>?> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }


  //get the user doc stream from firebase
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}