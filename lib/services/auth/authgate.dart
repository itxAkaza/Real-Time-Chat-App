import 'package:chatapp/Pages/Home_page.dart';
import 'package:chatapp/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData)
            {
              return HomePageScreen();
            }
          else
            {
              return LoginpageScreen();
            }
        },
      ),
    );
  }
}
