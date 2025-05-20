

import 'package:chatapp/Models/Messege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Chatservices
{
   // get instence of firestore
  final firestore=FirebaseFirestore.instance;
  final auth =FirebaseAuth.instance;


  // get user stream

  Stream<List<Map<String,dynamic>>>getUserStream(){
    return firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        // go throught each user and return the user
        final user=doc.data();
        return user;

      }).toList();

    });

  }

  // send messeges

   Future<void>sendMessege(String reciversId,meessege)async
   {
     // get current user info
     final String currentUserId=auth.currentUser!.uid;
     final String currentUserEmail=auth.currentUser!.email!;
     final Timestamp timestamp=Timestamp.now();

     //create a new messege from messege class

   Messege messege=new Messege(
       Senderid: currentUserId,
       SenderEmail: currentUserEmail,
       Reciverid: reciversId,
       messege: meessege,
       timestamp: timestamp
   );

     //constract chatroom id

     List<String>ids=[currentUserId,reciversId];
     ids.sort();// sort the array to get a unique id .it sort alphabetically
     String chatRoomID=ids.join("_");// joint the sorted id with uderscore

     //add new messege to db

     await firestore.collection("chat_rooms")
         .doc(chatRoomID)
         .collection("messege")
         .add(messege.toMap());

   }

  //get messeges

  Stream<QuerySnapshot>getMessege(String userid,String otherUserid)
  {
    List<String>ids=[userid,otherUserid];
    ids.sort();// sort the array to get a unique id .it sort alphabetically
    String chatRoomID=ids.join("_");

    return firestore.collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messege")
        .orderBy("timestamp",descending: false)
        .snapshots();


  }


}