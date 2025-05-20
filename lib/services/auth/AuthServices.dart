import 'package:chatapp/Util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authservices
{

  final auth=FirebaseAuth.instance;
  final firestoreref=FirebaseFirestore.instance;


  //get cureent user
  User? getCurrentUser(){
    return auth.currentUser;
  }

  // sign in

  Future<UserCredential>signinWithEmailPassword(String email,String password)async{

    try{
      UserCredential userCredential=await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      firestoreref.collection("Users").doc(userCredential.user!.uid).set({
        "uid":userCredential.user!.uid,
        "email":email
      });



      return userCredential;



    }on FirebaseAuthException catch(e)
    {
      throw Exception(e.code);

    }


  }

  //sign up

  Future<UserCredential> SignupWithEmailPassword(String email,String password) async
  {
    try
        {
          UserCredential userCredential=await auth.createUserWithEmailAndPassword(
              email: email,
              password: password
          );

          firestoreref.collection("Users").doc(userCredential.user!.uid).set({
            "uid":userCredential.user!.uid,
            "email":email
          });


          return userCredential;




        }
    on FirebaseAuthException catch(e)
        {
          throw Exception(e.code);
        }
  }

  // sign out

  Future<void> SignOut() async{
    try{
      return await auth.signOut();
    }
    on FirebaseAuthException catch(e)
    {
      throw Exception(e.code);
    }
  }

  // error
}